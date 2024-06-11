"""
    ColPackPartialColoring

Struct holding the parameters of a partial coloring as well as its results (which can be queried with [`get_colors`](@ref)).

# Fields

The fields of this struct are not part of the public API, they are only useful to interface with the C++ library [ColPack](https://github.com/CSCsw/ColPack).

# Constructors

    ColPackPartialColoring(
        filename::AbstractString,
        method::ColoringMethod,
        order::ColoringOrder;
        verbose::Bool=false    
    )

    ColPackPartialColoring(
        M::SparseMatrixCSC,
        method::ColoringMethod,
        order::ColoringOrder;
        verbose::Bool=false    
    )

Perform the partial coloring of a matrix that is either given directly or read from a file.

The users needs to specify a partial coloring `method` and an `order` on the vertices.

# See also

- [`ColoringMethod`](@ref)
- [`ColoringOrder`](@ref)
"""
mutable struct ColPackPartialColoring
    refColPack::Base.RefValue{Ptr{Cvoid}}
    coloring::Vector{Cint}
    method::ColoringMethod
    order::ColoringOrder
end

Base.unsafe_convert(::Type{Ptr{Cvoid}}, coloring::ColPackPartialColoring) = coloring.refColPack[]

function ColPackPartialColoring(
    filename::AbstractString,
    method::ColoringMethod,
    order::ColoringOrder;
    verbose::Bool=false,
)
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    reflen = Ref{Cint}(0)
    ret = build_partial_coloring_from_file(refColPack, reflen, filename, method.method, order.order, verbose)
    (ret == 0) && error("ColPack partial coloring failed.")
    coloring = zeros(Cint, reflen[])
    g = ColPackPartialColoring(refColPack, coloring, method, order)
    finalizer(free_partial_coloring, g)
    return g
end

function ColPackPartialColoring(
    M::SparseMatrixCSC,
    method::ColoringMethod,
    order::ColoringOrder;
    verbose::Bool=false,
)
    reflen = Ref{Cint}(0)
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    nrows, ncols = size(M)

    # The CSC format of M is the CSR format of Mᵀ.
    Mt_cols = Cint.(M.rowval)
    Mt_rows = Cint.(M.colptr)

    # ColPack expects sparse CSR matrices with 0-based indexing.
    Mt_cols .-= Cint(1)
    Mt_rows .-= Cint(1)

    (method.method == "ROW_PARTIAL_DISTANCE_TWO") && (colpack_method = "COLUMN_PARTIAL_DISTANCE_TWO")
    (method.method == "COLUMN_PARTIAL_DISTANCE_TWO") && (colpack_method = "ROW_PARTIAL_DISTANCE_TWO")
    ret = build_partial_coloring_from_csr(refColPack, reflen, Mt_rows, Mt_cols, ncols, nrows, colpack_method, order.order, verbose)
    (ret == 0) && error("ColPack partial coloring failed.")
    coloring = zeros(Cint, reflen[])
    g = ColPackPartialColoring(refColPack, coloring, ColoringMethod(colpack_method), order)
    finalizer(free_partial_coloring, g)
    return g
end

"""
    get_colors(coloring::ColPackPartialColoring)

Retrieve the colors from a [`ColPackPartialColoring`](@ref) as a vector of integers.
"""
function get_colors(coloring::ColPackPartialColoring)
    get_partial_coloring(coloring.refColPack[], coloring.coloring)
    coloring.coloring .+= Cint(1)
    return coloring.coloring
end
