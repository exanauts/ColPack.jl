var documenterSearchIndex = {"docs":
[{"location":"api/#API-reference","page":"API reference","title":"API reference","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"CollapsedDocStrings = true","category":"page"},{"location":"api/#Public","page":"API reference","title":"Public","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"Modules = [ColPack]\nPrivate = false","category":"page"},{"location":"api/#ColPack.ColPack","page":"API reference","title":"ColPack.ColPack","text":"ColPack\n\nA Julia interface to the C++ library ColPack for graph and sparse matrix coloring.\n\nExports\n\nColPackColoring\nColPackPartialColoring\nColPackBiColoring\ncolpack\nget_ordering\nget_colors\nncolors\ntimer_ordering\ntimer_coloring\n\n\n\n\n\n","category":"module"},{"location":"api/#ColPack.ColPackBiColoring","page":"API reference","title":"ColPack.ColPackBiColoring","text":"ColPackBiColoring\n\nStruct holding the parameters of a bicoloring as well as its results (which can be queried with get_colors).\n\ndanger: Danger\nThis is still experimental and not protected by semantic versioning, use at your own risk.\n\nConstructors\n\nColPackBiColoring(\n    filename::AbstractString,\n    method::String,\n    order::String;\n    verbose::Bool=false    \n)\n\nColPackBiColoring(\n    M::SparseMatrixCSC,\n    method::String,\n    order::String;\n    verbose::Bool=false    \n)\n\nPerform the coloring of a matrix that is either given directly or read from a .mtx file.\n\nThe users needs to specify\n\na bicoloring method among [\"IMPLICIT_COVERING__STAR_BICOLORING\", \"EXPLICIT_COVERING__STAR_BICOLORING\", \"EXPLICIT_COVERING__MODIFIED_STAR_BICOLORING\", \"IMPLICIT_COVERING__GREEDY_STAR_BICOLORING\"]\nan order on the vertices among [\"NATURAL\", \"RANDOM\", \"LARGEST_FIRST\", \"DYNAMIC_LARGEST_FIRST\", \"SMALLEST_LAST\", \"INCIDENCE_DEGREE\"]\n\nFields\n\nThe fields of this struct are not part of the public API, they are only useful to interface with the C++ library ColPack.\n\n\n\n\n\n","category":"type"},{"location":"api/#ColPack.ColPackColoring","page":"API reference","title":"ColPack.ColPackColoring","text":"ColPackColoring\n\nStruct holding the parameters of a coloring as well as its results (which can be queried with get_colors).\n\nConstructors\n\nColPackColoring(\n    filename::AbstractString,\n    method::String,\n    order::String;\n    verbose::Bool=false    \n)\n\nColPackColoring(\n    M::SparseMatrixCSC,\n    method::String,\n    order::String;\n    verbose::Bool=false    \n)\n\nPerform the coloring of a matrix that is either given directly or read from a .mtx file.\n\nThe users needs to specify\n\na coloring method among [\"DISTANCE_ONE\", \"ACYCLIC\", \"ACYCLIC_FOR_INDIRECT_RECOVERY\", \"STAR\", \"NAIVE_STAR\", \"RESTRICTED_STAR\", \"DISTANCE_TWO\"]\nan order on the vertices among [\"NATURAL\", \"RANDOM\", \"LARGEST_FIRST\", \"SMALLEST_LAST\", \"DYNAMIC_LARGEST_FIRST\", \"INCIDENCE_DEGREE\", \"DISTANCE_TWO_SMALLEST_LAST\", \"DISTANCE_TWO_LARGEST_FIRST\", \"DISTANCE_TWO_INCIDENCE_DEGREE\"]\n\nExample\n\njulia> using ColPack, SparseArrays\n\njulia> H = sparse([1 1 1; 1 1 0; 1 0 1])\n3×3 SparseMatrixCSC{Int64, Int64} with 7 stored entries:\n 1  1  1\n 1  1  ⋅\n 1  ⋅  1\n\njulia> get_colors(ColPackColoring(H, \"STAR\", \"NATURAL\"))\n3-element Vector{Int32}:\n 1\n 2\n 2\n\nFields\n\nThe fields of this struct are not part of the public API, they are only useful to interface with the C++ library ColPack.\n\n\n\n\n\n","category":"type"},{"location":"api/#ColPack.ColPackPartialColoring","page":"API reference","title":"ColPack.ColPackPartialColoring","text":"ColPackPartialColoring\n\nStruct holding the parameters of a partial coloring as well as its results (which can be queried with get_colors).\n\nConstructors\n\nColPackPartialColoring(\n    filename::AbstractString,\n    method::String,\n    order::String;\n    verbose::Bool=false    \n)\n\nColPackPartialColoring(\n    M::SparseMatrixCSC,\n    method::String,\n    order::String;\n    verbose::Bool=false    \n)\n\nPerform the partial coloring of a matrix that is either given directly or read from a .mtx file.\n\nThe users needs to specify:\n\na partial coloring method among [\"COLUMN_PARTIAL_DISTANCE_TWO\", \"ROW_PARTIAL_DISTANCE_TWO\"]\nan order on the vertices among [\"NATURAL\", \"RANDOM\", \"LARGEST_FIRST\", \"DYNAMIC_LARGEST_FIRST\", \"SMALLEST_LAST\", \"INCIDENCE_DEGREE\"]\n\nwarning: Warning\nTo perform a partial column coloring of a CSC matrix, we actually perform a partial row coloring of its transpose (which is a CSR matrix). Thus, the coloring results will in general differ between the file API and the matrix API.\n\nExample\n\njulia> using ColPack, SparseArrays\n\njulia> J = sparse([1 0 1; 1 1 0])\n2×3 SparseMatrixCSC{Int64, Int64} with 4 stored entries:\n 1  ⋅  1\n 1  1  ⋅\n\njulia> get_colors(ColPackPartialColoring(J, \"COLUMN_PARTIAL_DISTANCE_TWO\", \"NATURAL\"))\n3-element Vector{Int32}:\n 1\n 2\n 2\n\nFields\n\nThe fields of this struct are not part of the public API, they are only useful to interface with the C++ library ColPack.\n\n\n\n\n\n","category":"type"},{"location":"api/#ColPack.colpack-Tuple{String, String, String}","page":"API reference","title":"ColPack.colpack","text":"colpack(file::String, method::String, order::String; verbose::Bool=false)\n\nPerform graph coloring with the ColPack executable.\n\nfile: Indicates the graph file path.\nmethod: Indicates the method.\norder: Indicates the ordering.\nverbose: Indicates verbose flag will be turned on and there will display more rich information.\n\nExamples\n\ncolpack(\"./bcsstk01.mtx\", \"DISTANCE_ONE\", \"RANDOM\", verbose=true)\ncolpack(\"./bcsstk01.mtx\", \"ROW_PARTIAL_DISTANCE_TWO\", \"NATURAL\", verbose=true)\ncolpack(\"./bcsstk01.mtx\", \"COLUMN_PARTIAL_DISTANCE_TWO\", \"NATURAL\", verbose=true)\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.get_colors-Tuple{ColPackBiColoring}","page":"API reference","title":"ColPack.get_colors","text":"get_colors(coloring::ColPackBiColoring)\n\nRetrieve the colors from a ColPackBiColoring as two vectors of integers, one for the rows and one for the columns respectively.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.get_colors-Tuple{ColPackColoring}","page":"API reference","title":"ColPack.get_colors","text":"get_colors(coloring::ColPackColoring)\n\nRetrieve the colors from a ColPackColoring as a vector of integers.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.get_colors-Tuple{ColPackPartialColoring}","page":"API reference","title":"ColPack.get_colors","text":"get_colors(coloring::ColPackPartialColoring)\n\nRetrieve the colors from a ColPackPartialColoring as a vector of integers.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.get_ordering-Tuple{ColPackBiColoring}","page":"API reference","title":"ColPack.get_ordering","text":"get_ordering(coloring::ColPackBiColoring)\n\nRetrieve the ordering from a ColPackBiColoring as a vector of integers.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.get_ordering-Tuple{ColPackColoring}","page":"API reference","title":"ColPack.get_ordering","text":"get_ordering(coloring::ColPackColoring)\n\nRetrieve the ordering from a ColPackColoring as a vector of integers.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.get_ordering-Tuple{ColPackPartialColoring}","page":"API reference","title":"ColPack.get_ordering","text":"get_ordering(coloring::ColPackPartialColoring)\n\nRetrieve the ordering from a ColPackPartialColoring as a vector of integers.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.ncolors-Tuple{ColPackBiColoring}","page":"API reference","title":"ColPack.ncolors","text":"ncolors(coloring::ColPackBiColoring)\n\nRetrieve the number of colors from a ColPackBiColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.ncolors-Tuple{ColPackColoring}","page":"API reference","title":"ColPack.ncolors","text":"ncolors(coloring::ColPackColoring)\n\nRetrieve the number of colors from a ColPackColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.ncolors-Tuple{ColPackPartialColoring}","page":"API reference","title":"ColPack.ncolors","text":"ncolors(coloring::ColPackPartialColoring)\n\nRetrieve the number of colors from a ColPackPartialColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.timer_coloring-Tuple{ColPackBiColoring}","page":"API reference","title":"ColPack.timer_coloring","text":"timer_coloring(coloring::ColPackBiColoring)\n\nRetrieve the timer for coloring from a ColPackBiColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.timer_coloring-Tuple{ColPackColoring}","page":"API reference","title":"ColPack.timer_coloring","text":"timer_coloring(coloring::ColPackColoring)\n\nRetrieve the timer for coloring from a ColPackColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.timer_coloring-Tuple{ColPackPartialColoring}","page":"API reference","title":"ColPack.timer_coloring","text":"timer_coloring(coloring::ColPackPartialColoring)\n\nRetrieve the timer for coloring from a ColPackPartialColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.timer_ordering-Tuple{ColPackBiColoring}","page":"API reference","title":"ColPack.timer_ordering","text":"timer_ordering(coloring::ColPackBiColoring)\n\nRetrieve the timer for ordering from a ColPackBiColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.timer_ordering-Tuple{ColPackColoring}","page":"API reference","title":"ColPack.timer_ordering","text":"timer_ordering(coloring::ColPackColoring)\n\nRetrieve the timer for ordering from a ColPackColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#ColPack.timer_ordering-Tuple{ColPackPartialColoring}","page":"API reference","title":"ColPack.timer_ordering","text":"timer_ordering(coloring::ColPackPartialColoring)\n\nRetrieve the timer for ordering from a ColPackPartialColoring.\n\n\n\n\n\n","category":"method"},{"location":"api/#Internals","page":"API reference","title":"Internals","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"Modules = [ColPack]\nPublic = false","category":"page"},{"location":"#ColPack","page":"Home","title":"ColPack","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Build Status) (Image: Stable Documentation) (Image: Dev Documentation)","category":"page"},{"location":"","page":"Home","title":"Home","text":"A Julia interface to the C++ library ColPack for graph and sparse matrix coloring.","category":"page"},{"location":"#Getting-started","page":"Home","title":"Getting started","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"You can install this package by running the following command in a Julia Pkg REPL (the necessary binaries will be downloaded automatically):","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> add ColPack","category":"page"},{"location":"#Mathematical-background","page":"Home","title":"Mathematical background","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To understand the link between graph coloring and automatic differentiation, read the following survey:","category":"page"},{"location":"","page":"Home","title":"Home","text":"What Color Is Your Jacobian? Graph Coloring for Computing Derivatives, Gebremedhin et al. (2005)","category":"page"},{"location":"","page":"Home","title":"Home","text":"The ColPack library itself is described in:","category":"page"},{"location":"","page":"Home","title":"Home","text":"ColPack: Software for graph coloring and related problems in scientific computing, Gebremedhin et al. (2012)","category":"page"}]
}
