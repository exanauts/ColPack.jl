"""
    ColPackBiColoring

Struct holding the parameters of a bicoloring as well as its results (which can be queried with [`get_colors`](@ref)).

# Fields

The fields of this struct are not part of the public API, they are only useful to interface with the C++ library [ColPack](https://github.com/CSCsw/ColPack).

# Constructors

    ColPackBiColoring(
        filename::AbstractString,
        method::ColoringMethod,
        order::ColoringOrder;
        verbose::Bool=false    
    )

    ColPackBiColoring(
        M::SparseMatrixCSC,
        method::ColoringMethod,
        order::ColoringOrder;
        verbose::Bool=false    
    )

Perform the coloring of a matrix that is either given directly or read from a file.

The users needs to specify a bicoloring `method` and an `order` on the vertices.

# See also

- [`ColoringMethod`](@ref)
- [`ColoringOrder`](@ref)
"""
mutable struct ColPackBiColoring
    refColPack::Base.RefValue{Ptr{Cvoid}}
    coloring1::Vector{Cint}
    coloring2::Vector{Cint}
    method::ColoringMethod
    order::ColoringOrder
end

Base.unsafe_convert(::Type{Ptr{Cvoid}}, coloring::ColPackBiColoring) = coloring.refColPack[]

function ColPackBiColoring(
    filename::AbstractString,
    method::ColoringMethod,
    order::ColoringOrder;
    verbose::Bool=false,
)
    refColPack = Ref{Ptr{Cvoid}}(C_NULL)
    reflen1 = Ref{Cint}(0)
    reflen2 = Ref{Cint}(0)
    ret = build_bicoloring_from_file(refColPack, reflen1, reflen2, filename, method.method, order.order, verbose)
    (ret == 0) && error("ColPack bicoloring failed.")
    coloring1 = zeros(Cint, reflen1[])
    coloring2 = zeros(Cint, reflen2[])
    g = ColPackBiColoring(refColPack, coloring1, coloring2, method, order)
    finalizer(free_bicoloring, g)
    return g
end

"""
    get_colors(coloring::ColPackBiColoring)

Retrieve the colors from a [`ColPackBiColoring`](@ref) as vectors of integers.
"""
function get_colors(coloring::ColPackBiColoring)
    get_bicoloring(coloring.refColPack[], coloring.coloring1, coloring.coloring2)
    coloring.coloring1 .+= Cint(1)
    coloring.coloring2 .+= Cint(1)
    return coloring.coloring1, coloring.coloring2
end
