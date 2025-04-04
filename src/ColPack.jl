"""
    ColPack

A Julia interface to the C++ library [ColPack](https://github.com/CSCsw/ColPack) for graph and sparse matrix coloring.

# Exports

- [`ColPackColoring`](@ref)
- [`ColPackPartialColoring`](@ref)
- [`ColPackBiColoring`](@ref)
- [`colpack`](@ref)
- [`get_ordering`](@ref)
- [`get_colors`](@ref)
- [`ncolors`](@ref)
- [`timer_ordering`](@ref)
- [`timer_coloring`](@ref)
"""
module ColPack

# Imports

using ColPack_jll
using LinearAlgebra
using SparseArrays

# Definitions

include("libcolpack.jl")
include("options.jl")
include("utils.jl")
include("colpack_binary.jl")
include("colpack_coloring.jl")
include("colpack_partial_coloring.jl")
include("colpack_bicoloring.jl")

# Exports

export ColPackColoring, ColPackPartialColoring, ColPackBiColoring, colpack, get_ordering, get_colors, ncolors, timer_ordering, timer_coloring

end #module
