"""
    ColPack

A Julia interface to the C++ library [ColPack](https://github.com/CSCsw/ColPack) for graph and sparse matrix coloring.

# Exports

- [`ColPackColoring`](@ref)
- [`ColPackPartialColoring`](@ref)
- [`colpack`](@ref)
- [`get_colors`](@ref)
"""
module ColPack

# Imports

using ColPack_jll
using LinearAlgebra
using SparseArrays

# Definitions

include("libcolpack.jl")
include("options.jl")
include("colpack_binary.jl")
include("colpack_coloring.jl")
include("colpack_partial_coloring.jl")
include("colpack_bicoloring.jl")

# Exports

export ColPackColoring, ColPackPartialColoring, colpack, get_colors

end #module
