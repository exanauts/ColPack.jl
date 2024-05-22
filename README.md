# ColPack

[![Build Status](https://github.com/michel2323/ColPack.jl/actions/workflows/Test.yml/badge.svg?branch=master)](https://github.com/michel2323/ColPack.jl/actions/workflows/Test.yml?query=branch%master)
[![Dev Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://michel2323.github.io/ColPack.jl/dev/)

This is the Julia interface to [ColPack](https://github.com/CSCsw/ColPack) for graph and matrix coloring.

## Getting started

You can install this package by running the following command in a Julia Pkg REPL (the necessary binaries will be downloaded automatically):

```julia
pkg> add ColPack
```

Take a look at the tutorial in the documentation to get a feel for what you can do.

## Mathematical background

To understand the link between graph coloring and automatic differentiation, read the following survey:

> [_What Color Is Your Jacobian? Graph Coloring for Computing Derivatives_](https://epubs.siam.org/doi/10.1137/S0036144504444711), Gebremedhin et al. (2005)
