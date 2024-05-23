var documenterSearchIndex = {"docs":
[{"location":"api/","page":"API reference","title":"API reference","text":"CollapsedDocStrings = true","category":"page"},{"location":"api/#API-reference","page":"API reference","title":"API reference","text":"","category":"section"},{"location":"api/#Entry-points","page":"API reference","title":"Entry points","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"Modules = [ColPack]\nPages = [\"colpackcoloring.jl\", \"utils.jl\"]\nPrivate = false","category":"page"},{"location":"api/#ColPack.ColPackColoring","page":"API reference","title":"ColPack.ColPackColoring","text":"ColPackColoring\n\nStruct holding the parameters of a coloring as well as its results (which can be queried with get_colors).\n\nFields\n\nThe fields of this struct are not part of the public API, they are only useful to interface with the C++ library ColPack.\n\nConstructors\n\nColPackColoring(\n    filename::AbstractString,\n    method::ColoringMethod,\n    order::ColoringOrder;\n    verbose::Bool=false    \n)\n\nColPackColoring(\n    M::SparseMatrixCSC,\n    method::ColoringMethod,\n    order::ColoringOrder;\n    verbose::Bool=false    \n)\n\nPerform the coloring of a matrix that is either given directly or read from a file.\n\nThe users needs to specify a coloring method and an order on the vertices.\n\nSee also\n\nColoringMethod\nColoringOrder\n\n\n\n\n\n","category":"type"},{"location":"api/#ColPack.get_colors-Tuple{ColPackColoring}","page":"API reference","title":"ColPack.get_colors","text":"get_colors(coloring::ColPackColoring; verbose=false)\n\nRetrieve the colors from a ColPackColoring as a vector of integers.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.matrix2adjmatrix-Tuple{AbstractMatrix}","page":"API reference","title":"ColPack.matrix2adjmatrix","text":"matrix2adjmatrix(M::AbstractMatrix; partition_by_rows=true)\n\nCreate an adjacency matrix between the rows or between the columns of M, depending on whether partition_by_rows is true or false.\n\n\n\n\n\n","category":"method"},{"location":"api/#Coloring-method","page":"API reference","title":"Coloring method","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"Modules = [ColPack]\nPages = [\"method.jl\"]\nPrivate = false","category":"page"},{"location":"api/#ColPack.ColoringMethod","page":"API reference","title":"ColPack.ColoringMethod","text":"ColoringMethod\n\nRepresent a ColPack-compatible coloring method.\n\nFields\n\nmethod::String\n\nConstructors\n\nd1_coloring()\nd2_coloring()\nacyclic_coloring()\nstar_coloring()\n\n\n\n\n\n","category":"type"},{"location":"api/#ColPack.acyclic_coloring-Tuple{}","page":"API reference","title":"ColPack.acyclic_coloring","text":"acyclic_coloring()\n\nShortcut for ColoringMethod(\"ACYCLIC\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.d1_coloring-Tuple{}","page":"API reference","title":"ColPack.d1_coloring","text":"d1_coloring()\n\nShortcut for ColoringMethod(\"DISTANCE_ONE\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.d2_coloring-Tuple{}","page":"API reference","title":"ColPack.d2_coloring","text":"d2_coloring()\n\nShortcut for ColoringMethod(\"DISTANCE_TWO\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.star_coloring-Tuple{}","page":"API reference","title":"ColPack.star_coloring","text":"star_coloring()\n\nShortcut for ColoringMethod(\"STAR\").\n\n\n\n\n\n","category":"method"},{"location":"api/#Coloring-order","page":"API reference","title":"Coloring order","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"Modules = [ColPack]\nPages = [\"order.jl\"]\nPrivate = false","category":"page"},{"location":"api/#ColPack.ColoringOrder","page":"API reference","title":"ColPack.ColoringOrder","text":"ColoringOrder\n\nRepresent a ColPack-compatible coloring order.\n\nFields\n\norder::String\n\nConstructors\n\nnatural_ordering()\nlargest_first_ordering()\ndynamic_largest_first_ordering()\ndistance_two_largest_first_ordering()\nsmallest_last_ordering()\ndistance_two_smallest_last_ordering()\nincidence_degree_ordering()\ndistance_two_incidence_degree_ordering()\nrandom_ordering()\n\n\n\n\n\n","category":"type"},{"location":"api/#ColPack.distance_two_incidence_degree_ordering-Tuple{}","page":"API reference","title":"ColPack.distance_two_incidence_degree_ordering","text":"distance_two_incidence_degree_ordering()\n\nShortcut for ColoringOrder(\"DISTANCE_TWO_INCIDENCE_DEGREE\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.distance_two_largest_first_ordering-Tuple{}","page":"API reference","title":"ColPack.distance_two_largest_first_ordering","text":"distance_two_largest_first_ordering()\n\nShortcut for ColoringOrder(\"DISTANCE_TWO_LARGEST_FIRST\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.distance_two_smallest_last_ordering-Tuple{}","page":"API reference","title":"ColPack.distance_two_smallest_last_ordering","text":"distance_two_smallest_last_ordering()\n\nShortcut for ColoringOrder(\"DISTANCE_TWO_SMALLEST_LAST\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.dynamic_largest_first_ordering-Tuple{}","page":"API reference","title":"ColPack.dynamic_largest_first_ordering","text":"dynamic_largest_first_ordering()\n\nShortcut for ColoringOrder(\"DYNAMIC_LARGEST_FIRST\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.incidence_degree_ordering-Tuple{}","page":"API reference","title":"ColPack.incidence_degree_ordering","text":"incidence_degree_ordering()\n\nShortcut for ColoringOrder(\"INCIDENCE_DEGREE\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.largest_first_ordering-Tuple{}","page":"API reference","title":"ColPack.largest_first_ordering","text":"largest_first_ordering()\n\nShortcut for ColoringOrder(\"LARGEST_FIRST\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.natural_ordering-Tuple{}","page":"API reference","title":"ColPack.natural_ordering","text":"natural_ordering()\n\nShortcut for ColoringOrder(\"NATURAL\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.random_ordering-Tuple{}","page":"API reference","title":"ColPack.random_ordering","text":"random_ordering()\n\nShortcut for ColoringOrder(\"RANDOM\").\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.smallest_last_ordering-Tuple{}","page":"API reference","title":"ColPack.smallest_last_ordering","text":"smallest_last_ordering()\n\nShortcut for ColoringOrder(\"SMALLEST_LAST\").\n\n\n\n\n\n","category":"method"},{"location":"api/#Internals","page":"API reference","title":"Internals","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"Modules = [ColPack]\nPublic = false","category":"page"},{"location":"api/#ColPack._cols_by_rows-Tuple{Any, Any}","page":"API reference","title":"ColPack._cols_by_rows","text":"    _cols_by_rows(rows_index, cols_index)\n\nReturns a vector of rows where each row contains a vector of its column indices.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack._rows_by_cols-Tuple{Any, Any}","page":"API reference","title":"ColPack._rows_by_cols","text":"    _rows_by_cols(rows_index, cols_index)\n\nReturns a vector of columns where each column contains a vector of its row indices.\n\n\n\n\n\n","category":"method"},{"location":"#ColPack","page":"Home","title":"ColPack","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Build Status) (Image: Stable Documentation) (Image: Dev Documentation)","category":"page"},{"location":"","page":"Home","title":"Home","text":"This is the Julia interface to ColPack for graph and matrix coloring.","category":"page"},{"location":"#Getting-started","page":"Home","title":"Getting started","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"You can install this package by running the following command in a Julia Pkg REPL (the necessary binaries will be downloaded automatically):","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> add ColPack","category":"page"},{"location":"","page":"Home","title":"Home","text":"Take a look at the tutorial in the documentation to get a feel for what you can do.","category":"page"},{"location":"#Mathematical-background","page":"Home","title":"Mathematical background","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To understand the link between graph coloring and automatic differentiation, read the following survey:","category":"page"},{"location":"","page":"Home","title":"Home","text":"What Color Is Your Jacobian? Graph Coloring for Computing Derivatives, Gebremedhin et al. (2005)","category":"page"},{"location":"tutorial/#Tutorial","page":"Tutorial","title":"Tutorial","text":"","category":"section"},{"location":"tutorial/#Jacobian-coloring","page":"Tutorial","title":"Jacobian coloring","text":"","category":"section"},{"location":"tutorial/","page":"Tutorial","title":"Tutorial","text":"julia> using ColPack, SparseArrays","category":"page"},{"location":"tutorial/","page":"Tutorial","title":"Tutorial","text":"julia> J = sparse([\n           1 1 0 0 0\n           0 0 1 0 0\n           0 1 0 1 0\n           0 0 0 1 1\n       ]);\n\njulia> adjJ = ColPack.matrix2adjmatrix(J; partition_by_rows=false)\n5×5 SparseMatrixCSC{Float64, UInt32} with 6 stored entries:\n  ⋅   1.0   ⋅    ⋅    ⋅ \n 1.0   ⋅    ⋅   1.0   ⋅ \n  ⋅    ⋅    ⋅    ⋅    ⋅ \n  ⋅   1.0   ⋅    ⋅   1.0\n  ⋅    ⋅    ⋅   1.0   ⋅ ","category":"page"},{"location":"tutorial/","page":"Tutorial","title":"Tutorial","text":"julia> coloring = ColPackColoring(adjJ, d1_coloring(), natural_ordering());\n\njulia> colors = get_colors(coloring)\n5-element Vector{Int64}:\n 1\n 2\n 1\n 1\n 2\n\njulia> length(unique(colors)) == 2\ntrue","category":"page"},{"location":"tutorial/#Hessian-coloring","page":"Tutorial","title":"Hessian coloring","text":"","category":"section"},{"location":"tutorial/","page":"Tutorial","title":"Tutorial","text":"warning: Warning\nWork in progress","category":"page"}]
}
