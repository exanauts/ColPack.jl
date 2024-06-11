#=
Sources:
- https://github.com/CSCsw/ColPack/tree/master/Examples
=#

## Coloring on general graphs

const COLORING_METHODS = [
    "DISTANCE_ONE",
    "ACYCLIC",
    "ACYCLIC_FOR_INDIRECT_RECOVERY",
    "STAR",
    "RESTRICTED_STAR",
    "DISTANCE_TWO",
]

const COLORING_ORDERS = [
    "NATURAL",
    "RANDOM",
    "LARGEST_FIRST",
    "SMALLEST_LAST",
    "DYNAMIC_LARGEST_FIRST",
    "INCIDENCE_DEGREE",
]

## Partial coloring on bipartite graphs

const PARTIAL_COLORING_METHODS = [
    "COLUMN_PARTIAL_DISTANCE_TWO",  #
    "ROW_PARTIAL_DISTANCE_TWO",
]

#=
Was DYNAMIC_LARGEST_FIRST forgotten in the source code?
https://github.com/CSCsw/ColPack/blob/9a7293a8dfd66a60434496b8df5ebb4274d70339/src/BipartiteGraphPartialColoring/BipartiteGraphPartialOrdering.cpp#L1859-L1938
=#

const PARTIAL_COLORING_ORDERS = [
    "NATURAL",
    "RANDOM",
    "LARGEST_FIRST",
    # "DYNAMIC_LARGEST_FIRST",  
    "SMALLEST_LAST",
    "INCIDENCE_DEGREE",
]

## Bicoloring on bipartite graphs

const BICOLORING_METHODS = [
    "IMPLICIT_COVERING__STAR_BICOLORING",
    "EXPLICIT_COVERING__STAR_BICOLORING",
    "EXPLICIT_COVERING__MODIFIED_STAR_BICOLORING",
    "IMPLICIT_COVERING__GREEDY_STAR_BICOLORING",
]

const BICOLORING_ORDERS = [
    "NATURAL",
    "RANDOM",
    "LARGEST_FIRST",
    "DYNAMIC_LARGEST_FIRST",
    "SMALLEST_LAST",
    "INCIDENCE_DEGREE",
]
