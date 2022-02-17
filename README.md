# ColPack
[![][build-stable-img]][build-url]

This is the Julia interface to [ColPack](https://github.com/CSCsw/ColPack).

## Usage

### Read matrix market file
```julia
using ColPack
using MatrixMarket
coloring = ColPackColoring("m.mtx", ColPack.d1, "RANDOM")
println("Number of colors: ", length(unique(get_colors(coloring))))
println("Vector of vertex colors: ", get_colors(coloring))
```
### Pass the adjacency graph as a symmetric matrix of type `SparseMatrixCSC`
```julia
using ColPack
using LinearAlgebra
using SparseArrays
A = convert(SparseMatrixCSC, Symmetric(sprand(100,100,0.1)))
coloring = ColPackColoring(A, ColPack.d1, "RANDOM")
println("Number of colors: ", length(unique(get_colors(coloring))))
println("Vector of vertex colors: ", get_colors(coloring))
```


[build-url]: https://github.com/michel2323/ColPack.jl/actions?query=workflow
[build-stable-img]: https://github.com/michel2323/ColPack.jl/workflows/Run%20tests/badge.svg?branch=master
