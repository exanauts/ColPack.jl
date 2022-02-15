using ColPack
using MatrixMarket
using SparseArrays
using SparseDiffTools
using LinearAlgebra

const filename = "/scratch/jac_case9241pegase_17036.mtx"

orderings = Vector{String}()

push!(orderings, "NATURAL")
push!(orderings, "LARGEST_FIRST")
push!(orderings, "DYNAMIC_LARGEST_FIRST")
push!(orderings, "DISTANCE_TWO_LARGEST_FIRST")
push!(orderings, "SMALLEST_LAST")
push!(orderings, "DISTANCE_TWO_SMALLEST_LAST")
push!(orderings, "INCIDENCE_DEGREE")
push!(orderings, "DISTANCE_TWO_INCIDENCE_DEGREE")
push!(orderings, "RANDOM")

verbose = 1
A = MatrixMarket.mmread(filename)

@time sparsediff_coloring = SparseDiffTools.matrix_colors(A)
ncolor = size(unique(sparsediff_coloring),1)
@time colpack_coloring = ColPackColoring("/scratch/jac_case9241pegase_17036.mtx", ColPack.d1, "RANDOM", verbose)

for ordering in orderings
    colpack_coloring = ColPackColoring("/scratch/jac_case9241pegase_17036.mtx", ColPack.d1, ordering, verbose)
end
colors = get_colors(colpack_coloring)
@show length(unique(colors))
