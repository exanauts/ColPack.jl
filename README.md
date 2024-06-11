# ColPack

[![Build Status](https://github.com/exanauts/ColPack.jl/actions/workflows/Test.yml/badge.svg?branch=master)](https://github.com/exanauts/ColPack.jl/actions/workflows/Test.yml?query=branch%master)
[![Stable Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://exanauts.github.io/ColPack.jl/stable/)
[![Dev Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://exanauts.github.io/ColPack.jl/dev/)

A Julia interface to the C++ library [ColPack](https://github.com/CSCsw/ColPack) for graph and sparse matrix coloring.

## Getting started

You can install this package by running the following command in a Julia Pkg REPL (the necessary binaries will be downloaded automatically):

```julia
pkg> add ColPack
```

## Mathematical background

To understand the link between graph coloring and automatic differentiation, read the following survey:

> [_What Color Is Your Jacobian? Graph Coloring for Computing Derivatives_](https://epubs.siam.org/doi/10.1137/S0036144504444711), Gebremedhin et al. (2005)

The ColPack library itself is described in:

> [_ColPack: Software for graph coloring and related problems in scientific computing_](https://dl.acm.org/doi/10.1145/2513109.2513110), Gebremedhin et al. (2012)