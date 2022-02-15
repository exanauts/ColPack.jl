# ColPack
[![][build-stable-img]][build-url]

This is the Julia interface to [ColPack](https://github.com/CSCsw/ColPack).

## Usage
```julia
verbose = 1
coloring = ColPackColoring("M.mtx", ColPack.d1, "RANDOM", 1)

println("Number of colors: ", length(unique(get_colors(coloring))))
println("Vector of vertex colors: ", get_colors(coloring))
```
[build-url]: https://github.com/michel2323/ColPack.jl/actions?query=workflow

[build-stable-img]: https://github.com/michel2323/ColPack.jl/workflows/Run%20tests/badge.svg?branch=master