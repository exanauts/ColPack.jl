"""
    ColPackColoring

Struct holding the parameters of a coloring as well as its results (which can be queried with [`get_colors`](@ref)).

# Constructors

    ColPackColoring(
        filename::AbstractString,
        method::String,
        order::String;
        verbose::Bool=false    
    )

    ColPackColoring(
        M::SparseMatrixCSC,
        method::String,
        order::String;
        verbose::Bool=false    
    )

Perform the coloring of a matrix that is either given directly or read from a `.mtx` file.

The users needs to specify

- a coloring `method` among `$COLORING_METHODS`
- an `order` on the vertices among `$COLORING_ORDERS`

# Example

```jldoctest
julia> using ColPack, SparseArrays

julia> H = sparse([1 1 1; 1 1 0; 1 0 1])
3×3 SparseMatrixCSC{Int64, Int64} with 7 stored entries:
 1  1  1
 1  1  ⋅
 1  ⋅  1

julia> get_colors(ColPackColoring(H, "STAR", "NATURAL"))
3-element Vector{Int32}:
 1
 2
 2
```

# Fields
        
The fields of this struct are not part of the public API, they are only useful to interface with the C++ library [ColPack](https://github.com/CSCsw/ColPack).
"""
mutable struct ColPackColoring
    refColPack::Base.RefValue{Ptr{Cvoid}}
    coloring::Vector{Cint}
    method::String
    order::String
end

Base.unsafe_convert(::Type{Ptr{Cvoid}}, coloring::ColPackColoring) = coloring.refColPack[]

function ColPackColoring(
    filename::AbstractString, method::String, order::String; verbose::Bool=false
)
    if !(method in COLORING_METHODS)
        throw(ArgumentError("""Method "$method" is not in $COLORING_METHODS"""))
    end
    if !(order in COLORING_ORDERS)
        throw(ArgumentError("""Order "$order" is not in $COLORING_ORDERS"""))
    end
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    reflen = Ref{Cint}(0)
    ret = build_coloring_from_file(refColPack, reflen, filename, method, order, verbose)
    (ret == 0) && error("ColPack coloring failed.")
    coloring = zeros(Cint, reflen[])
    g = ColPackColoring(refColPack, coloring, method, order)
    finalizer(free_coloring, g)
    return g
end

function ColPackColoring(
    M::SparseMatrixCSC, method::String, order::String; verbose::Bool=false
)
    if !(method in COLORING_METHODS)
        throw(ArgumentError("""Method "$method" is not in $COLORING_METHODS"""))
    end
    if !(order in COLORING_ORDERS)
        throw(ArgumentError("""Order "$order" is not in $COLORING_ORDERS"""))
    end
    if size(M, 1) != size(M, 2)
        throw(DimensionMismatch("Matrix must be square (and symmetric)"))
    end
    # We expect M to be symmetric.
    adolc, adolc_mem = csr_to_adolc(M)
    nrows = size(M, 2)
    reflen = Ref{Cint}(0)
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    ret = build_coloring_from_adolc(refColPack, reflen, adolc, nrows, method, order, verbose)
    (ret == 0) && error("ColPack coloring failed.")

    coloring = zeros(Cint, reflen[])
    g = ColPackColoring(refColPack, coloring, method, order)
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

"""
    ncolors(coloring::ColPackColoring)

Retrieve the number of colors from a [`ColPackColoring`](@ref).
"""
function ncolors(coloring::ColPackColoring)
    return ncolors_coloring(coloring.refColPack[])
end
