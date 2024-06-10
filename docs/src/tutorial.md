# Tutorial

## Jacobian coloring

```jldoctest tuto
julia> using ColPack, SparseArrays
```

```jldoctest tuto
julia> J = sparse([
           1 1 0 0 0
           0 0 1 0 0
           0 1 0 1 0
           0 0 0 1 1
       ]);

julia> adjJ = ColPack.matrix2adjmatrix(J; partition_by_rows=false)
5×5 SparseMatrixCSC{Float64, UInt32} with 6 stored entries:
  ⋅   1.0   ⋅    ⋅    ⋅ 
 1.0   ⋅    ⋅   1.0   ⋅ 
  ⋅    ⋅    ⋅    ⋅    ⋅ 
  ⋅   1.0   ⋅    ⋅   1.0
  ⋅    ⋅    ⋅   1.0   ⋅ 
```

```jldoctest tuto
julia> coloring = ColPackColoring(adjJ, d1_coloring(), natural_ordering());

julia> colors = get_colors(coloring)
5-element Vector{Int32}:
 1
 2
 1
 1
 2

julia> length(unique(colors)) == 2
true
```

## Hessian coloring

!!! warning
    Work in progress