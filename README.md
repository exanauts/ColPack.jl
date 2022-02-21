# ColPack
[![][build-stable-img]][build-url]

This is the Julia interface to [ColPack](https://github.com/CSCsw/ColPack).

## Usage
### Jacobian coloring by columns
```julia
using ColPack
using SparseArrays

# Example matrix/Jacobian
A = [
    [1.0 1.0 0.0 0.0 0.0];
    [0.0 0.0 1.0 0.0 0.0];
    [0.0 1.0 0.0 1.0 0.0];
    [0.0 0.0 0.0 1.0 1.0];
]

A = sparse(A)

# Create adjacency matrix for column coloring
adjA = ColPack.matrix2adjmatrix(A; partition_by_rows=false)

coloring = ColPackColoring(adjA, d1_coloring(), random_ordering())
println("Number of colors: ", length(unique(get_colors(coloring))))
println("Vector of vertex colors: ", get_colors(coloring))
```


[build-url]: https://github.com/michel2323/ColPack.jl/actions?query=workflow
[build-stable-img]: https://github.com/michel2323/ColPack.jl/workflows/Run%20tests/badge.svg?branch=master
