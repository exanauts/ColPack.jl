module ColPack

# Imports

using ColPack_jll
using LinearAlgebra
using SparseArrays

# Definitions

abstract type AbstractColoring end
abstract type AbstractOrdering end

include("colorings.jl")
include("orderings.jl")
include("utils.jl")
include("ccalls.jl")

# Exports

export AbstractColoring
export AbstractOrdering

export COLORINGS
export d1_coloring, d2_coloring, acyclic_coloring, star_coloring

export ORDERINGS
export natural_ordering, largest_first_ordering, dynamic_largest_first_ordering, distance_two_largest_first_ordering
export smallest_last_ordering, distance_two_smallest_last_ordering, incidence_degree_ordering, distance_two_incidence_degree_ordering
export random_ordering

export matrix2adjmatrix

export ColPackColoring, get_colors

end #module
