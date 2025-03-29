"""
    ColPackBiColoring

Struct holding the parameters of a bicoloring as well as its results (which can be queried with [`get_colors`](@ref)).

!!! danger
    This is still experimental and not protected by semantic versioning, use at your own risk.

# Constructors

    ColPackBiColoring(
        filename::AbstractString,
        method::String,
        order::String;
        verbose::Bool=false    
    )
    
    ColPackBiColoring(
        M::SparseMatrixCSC,
        method::String,
        order::String;
        verbose::Bool=false    
    )
        
Perform the coloring of a matrix that is either given directly or read from a `.mtx` file.

The users needs to specify

- a bicoloring `method` among `$BICOLORING_METHODS`
- an `order` on the vertices among `$BICOLORING_ORDERS`

# Fields
        
The fields of this struct are not part of the public API, they are only useful to interface with the C++ library [ColPack](https://github.com/CSCsw/ColPack).
"""
mutable struct ColPackBiColoring
    refColPack::Base.RefValue{Ptr{Cvoid}}
    ordering::Vector{Cint}
    coloring1::Vector{Cint}
    coloring2::Vector{Cint}
    method::String
    order::String
end

Base.unsafe_convert(::Type{Ptr{Cvoid}}, coloring::ColPackBiColoring) = coloring.refColPack[]

function ColPackBiColoring(
    filename::AbstractString, method::String, order::String; verbose::Bool=false
)
    if !(method in BICOLORING_METHODS)
        throw(ArgumentError("""Method "$method" is not in $BICOLORING_METHODS"""))
    end
    if !(order in BICOLORING_ORDERS)
        throw(ArgumentError("""Order "$order" is not in $BICOLORING_ORDERS"""))
    end
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    reflen1 = Ref{Cint}(0)
    reflen2 = Ref{Cint}(0)
    ret = build_bicoloring_from_file(
        refColPack, reflen1, reflen2, filename, method, order, verbose
    )
    (ret == 0) && error("ColPack bicoloring failed.")
    ordering = zeros(Cint, reflen1[] + reflen2[])
    coloring1 = zeros(Cint, reflen1[])
    coloring2 = zeros(Cint, reflen2[])
    g = ColPackBiColoring(refColPack, ordering, coloring1, coloring2, method, order)
    finalizer(free_bicoloring, g)
    return g
end

function ColPackBiColoring(
    M::SparseMatrixCSC, method::String, order::String; verbose::Bool=false
)
    if !(method in BICOLORING_METHODS)
        throw(ArgumentError("""Method "$method" is not in $BICOLORING_METHODS"""))
    end
    if !(order in BICOLORING_ORDERS)
        throw(ArgumentError("""Order "$order" is not in $BICOLORING_ORDERS"""))
    end
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    reflen1 = Ref{Cint}(0)
    reflen2 = Ref{Cint}(0)
    nrows, ncols = size(M)

    # Version adolc
    Mᵀ = sparse(M')
    adolc, adolc_mem = csr_to_adolc(Mᵀ)
    ret = build_bicoloring_from_adolc(refColPack, reflen1, reflen2, adolc, nrows, ncols, method, order, verbose)

    # Version csc
    # ColPack expects sparse CSC / CSR matrices with 0-based indexing.
    # rowval = Cint.(M.rowval) .- Cint(1)
    # colptr = Cint.(M.colptr) .- Cint(1)
    # ret = build_bicoloring_from_csc(refColPack, reflen1, reflen2, rowval, colptr, nrows, ncols, method, order, verbose)
    (ret == 0) && error("ColPack partial coloring failed.")
    ordering = zeros(Cint, reflen1[] + reflen2[])
    coloring1 = zeros(Cint, reflen1[])
    coloring2 = zeros(Cint, reflen2[])
    g = ColPackBiColoring(refColPack, ordering, coloring1, coloring2, method, order)
    finalizer(free_partial_coloring, g)
    return g
end

"""
    get_ordering(coloring::ColPackBiColoring)

Retrieve the ordering from a [`ColPackBiColoring`](@ref) as a vector of integers.
"""
function get_ordering(coloring::ColPackBiColoring)
    order_bicoloring(coloring.refColPack[], coloring.ordering)
    coloring.ordering .+= Cint(1)
    return coloring.ordering
end

"""
    get_colors(coloring::ColPackBiColoring)

Retrieve the colors from a [`ColPackBiColoring`](@ref) as two vectors of integers, one for the rows and one for the columns respectively.
"""
function get_colors(coloring::ColPackBiColoring)
    colors_bicoloring(coloring.refColPack[], coloring.coloring1, coloring.coloring2)
    #=
    Zero is a neutral color in bicoloring, it may make sense to keep it.
    I am not yet sure how the coloring vectors are defined.
    =#
    coloring.coloring1 .+= Cint(1)
    coloring.coloring2 .+= Cint(1)
    return coloring.coloring1, coloring.coloring2
end

"""
    ncolors(coloring::ColPackBiColoring)

Retrieve the number of colors from a [`ColPackBiColoring`](@ref).
"""
function ncolors(coloring::ColPackBiColoring)
    return ncolors_bicoloring(coloring.refColPack[])
end

"""
    timer_ordering(coloring::ColPackBiColoring)

Retrieve the timer for ordering from a [`ColPackBiColoring`](@ref).
"""
function timer_ordering(coloring::ColPackBiColoring)
    return timer_order_bicoloring(coloring.refColPack[])
end

"""
    timer_coloring(coloring::ColPackBiColoring)

Retrieve the timer for coloring from a [`ColPackBiColoring`](@ref).
"""
function timer_coloring(coloring::ColPackBiColoring)
    return timer_colors_bicoloring(coloring.refColPack[])
end
