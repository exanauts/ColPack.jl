"""
    ColPackPartialColoring

Struct holding the parameters of a partial coloring as well as its results (which can be queried with [`get_colors`](@ref)).

# Constructors

    ColPackPartialColoring(
        filename::AbstractString,
        method::String,
        order::String;
        verbose::Bool=false    
    )

    ColPackPartialColoring(
        M::SparseMatrixCSC,
        method::String,
        order::String;
        verbose::Bool=false    
    )

Perform the partial coloring of a matrix that is either given directly or read from a `.mtx` file.

The users needs to specify:

- a partial coloring `method` among `$PARTIAL_COLORING_METHODS`
- an `order` on the vertices among `$PARTIAL_COLORING_ORDERS`

!!! warning
    To perform a partial column coloring of a CSC matrix, we actually perform a partial row coloring of its transpose (which is a CSR matrix). Thus, the coloring results will in general differ between the file API and the matrix API.

# Example

```jldoctest
julia> using ColPack, SparseArrays

julia> J = sparse([1 0 1; 1 1 0])
2×3 SparseMatrixCSC{Int64, Int64} with 4 stored entries:
 1  ⋅  1
 1  1  ⋅

julia> get_colors(ColPackPartialColoring(J, "COLUMN_PARTIAL_DISTANCE_TWO", "NATURAL"))
3-element Vector{Int32}:
 1
 2
 2
```

# Fields

The fields of this struct are not part of the public API, they are only useful to interface with the C++ library [ColPack](https://github.com/CSCsw/ColPack).
"""
mutable struct ColPackPartialColoring
    refColPack::Base.RefValue{Ptr{Cvoid}}
    coloring::Vector{Cint}
    method::String
    order::String
end

function Base.unsafe_convert(::Type{Ptr{Cvoid}}, coloring::ColPackPartialColoring)
    return coloring.refColPack[]
end

function switch(method::String)
    if method == "ROW_PARTIAL_DISTANCE_TWO"
        return "COLUMN_PARTIAL_DISTANCE_TWO"
    elseif method == "COLUMN_PARTIAL_DISTANCE_TWO"
        return "ROW_PARTIAL_DISTANCE_TWO"
    else
        throw(ArgumentError("Invalid method"))
    end
end

function ColPackPartialColoring(
    filename::AbstractString, method::String, order::String; verbose::Bool=false
)
    if !(method in PARTIAL_COLORING_METHODS)
        throw(ArgumentError("""Method "$method" is not in $PARTIAL_COLORING_METHODS"""))
    end
    if !(order in PARTIAL_COLORING_ORDERS)
        throw(ArgumentError("""Order "$order" is not in $PARTIAL_COLORING_ORDERS"""))
    end
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    reflen = Ref{Cint}(0)
    ret = build_partial_coloring_from_file(
        refColPack, reflen, filename, method, order, verbose
    )
    (ret == 0) && error("ColPack partial coloring failed.")
    coloring = zeros(Cint, reflen[])
    g = ColPackPartialColoring(refColPack, coloring, method, order)
    finalizer(free_partial_coloring, g)
    return g
end

function ColPackPartialColoring(
    M::SparseMatrixCSC, method::String, order::String; verbose::Bool=false
)
    if !(method in PARTIAL_COLORING_METHODS)
        throw(ArgumentError("""Method "$method" is not in $PARTIAL_COLORING_METHODS"""))
    end
    if !(order in PARTIAL_COLORING_ORDERS)
        throw(ArgumentError("""Order "$order" is not in $PARTIAL_COLORING_ORDERS"""))
    end
    reflen = Ref{Cint}(0)
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    nrows, ncols = size(M)

    # The CSC format of M is the CSR format of Mᵀ.
    Mt_cols = Cint.(M.rowval)
    Mt_rows = Cint.(M.colptr)

    # ColPack expects sparse CSR matrices with 0-based indexing.
    Mt_cols .-= Cint(1)
    Mt_rows .-= Cint(1)

    ret = build_partial_coloring_from_csr(
        refColPack, reflen, Mt_rows, Mt_cols, ncols, nrows, switch(method), order, verbose
    )
    (ret == 0) && error("ColPack partial coloring failed.")
    coloring = zeros(Cint, reflen[])
    g = ColPackPartialColoring(refColPack, coloring, switch(method), order)
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
