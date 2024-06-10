"""
    ColPackColoring

Struct holding the parameters of a coloring as well as its results (which can be queried with [`get_colors`](@ref)).

# Fields

The fields of this struct are not part of the public API, they are only useful to interface with the C++ library [ColPack](https://github.com/CSCsw/ColPack).

# Constructors

    ColPackColoring(
        filename::AbstractString,
        method::ColoringMethod,
        order::ColoringOrder;
        verbose::Bool=false    
    )

    ColPackColoring(
        M::SparseMatrixCSC,
        method::ColoringMethod,
        order::ColoringOrder;
        verbose::Bool=false    
    )

Perform the coloring of a matrix that is either given directly or read from a file.

The users needs to specify a coloring `method` and an `order` on the vertices.

# See also

- [`ColoringMethod`](@ref)
- [`ColoringOrder`](@ref)
"""
mutable struct ColPackColoring
    refColPack::Base.RefValue{Ptr{Cvoid}}
    coloring::Vector{Cint}
    method::ColoringMethod
    order::ColoringOrder
    csr::Union{Vector{Ptr{Cuint}},Nothing}
end

Base.unsafe_convert(::Type{Ptr{Cvoid}}, coloring::ColPackColoring) = coloring.refColPack[]

function ColPackColoring(
    filename::AbstractString,
    method::ColoringMethod,
    order::ColoringOrder;
    verbose::Bool=false,
)
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    reflen = Ref{Cint}(0)
    ret = build_coloring_from_file(refColPack, reflen, filename, method.method, order.order, verbose)
    (ret == 0) && error("ColPack coloring failed.")
    coloring = zeros(Cint, reflen[])
    g = ColPackColoring(refColPack, coloring, method, order, nothing)
    finalizer(free_coloring, g)
    return g
end

function ColPackColoring(
    M::SparseMatrixCSC{VT,IT},
    method::ColoringMethod,
    order::ColoringOrder;
    verbose::Bool=false,
) where {VT,IT}
    @assert issymmetric(M)
    csr = Vector{Ref{Cuint}}()
    csr_mem = Vector{Vector{Cuint}}()
    for i in 1:(length(M.colptr) - 1)
        vec = Vector{Cuint}()
        # Number of column elements
        push!(vec, Cuint(M.colptr[i + 1] - M.colptr[i]))
        for j in M.colptr[i]:(M.colptr[i + 1] - 1)
            push!(vec, Cuint(M.rowval[j] - 1))
        end
        push!(csr, Base.unsafe_convert(Ptr{Cuint}, vec))
        push!(csr_mem, vec)
    end
    nrows = size(M, 2)
    reflen = Ref{Cint}(0)
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    ret = build_coloring_from_csr(refColPack, reflen, csr, nrows, method.method, order.order, verbose)
    (ret == 0) && error("ColPack coloring failed.")

    coloring = zeros(Cint, reflen[])
    g = ColPackColoring(refColPack, coloring, method, order, csr)
    finalizer(free_coloring, g)
    return g
end

"""
    get_colors(coloring::ColPackColoring)

Retrieve the colors from a [`ColPackColoring`](@ref) as a vector of integers.
"""
function get_colors(coloring::ColPackColoring)
    get_coloring(coloring.refColPack[], coloring.coloring)
    coloring.coloring .+= Cint(1)
    return coloring.coloring
end
