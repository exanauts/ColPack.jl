module ColPack

# Imports

using ColPack_jll
using LinearAlgebra
using SparseArrays

# Definitions

include("libcolpack.jl")
include("method.jl")
include("order.jl")
include("utils.jl")
include("colpack_coloring.jl")
include("colpack_partial_coloring.jl")
include("colpack_bicoloring.jl")

# Exports

export ColoringMethod
export d1_coloring, d2_coloring, acyclic_coloring, star_coloring
export row_partial_d2_coloring, column_partial_d2_coloring
export implicit_star_bicoloring, explicit_star_bicoloring, explicit_modified_star_bicoloring, implicit_greedy_star_bicoloring

export ColoringOrder
export natural_ordering, largest_first_ordering, dynamic_largest_first_ordering, distance_two_largest_first_ordering
export smallest_last_ordering, distance_two_smallest_last_ordering, incidence_degree_ordering, distance_two_incidence_degree_ordering
export random_ordering

export matrix2adjmatrix

export ColPackColoring, ColPackPartialColoring, ColPackBiColoring, get_colors

end #module
