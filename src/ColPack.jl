module ColPack

# Imports

using ColPack_jll
using LinearAlgebra
using SparseArrays

# Definitions

include("method.jl")
include("order.jl")
include("utils.jl")
include("colpackcoloring.jl")

# Exports

export ColoringMethod
export d1_coloring, d2_coloring, acyclic_coloring, star_coloring

export ColoringOrder
export natural_ordering, largest_first_ordering, dynamic_largest_first_ordering, distance_two_largest_first_ordering
export smallest_last_ordering, distance_two_smallest_last_ordering, incidence_degree_ordering, distance_two_incidence_degree_ordering
export random_ordering

export matrix2adjmatrix

export ColPackColoring, get_colors

end #module
