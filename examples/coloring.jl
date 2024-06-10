using ColPack
using SuiteSparseMatrixCollection
using MatrixMarket
using SparseArrays
using SparseDiffTools
using LinearAlgebra

ssmc = ssmc_db()
matrices = ssmc_matrices(ssmc, "Bodendiek", "CurlCurl_0")
folders = fetch_ssmc(matrices, format="MM")
paths = joinpath.(folders, matrices.name .* ".mtx")
A = MatrixMarket.mmread(paths[1])

orderings = Vector{ColoringOrder}()
push!(orderings, natural_ordering())
push!(orderings, largest_first_ordering())
push!(orderings, dynamic_largest_first_ordering())
push!(orderings, distance_two_largest_first_ordering())
push!(orderings, smallest_last_ordering())
push!(orderings, distance_two_smallest_last_ordering())
push!(orderings, incidence_degree_ordering())
push!(orderings, distance_two_incidence_degree_ordering())
push!(orderings, random_ordering())

@time sparsediff_coloring = SparseDiffTools.matrix_colors(A)
ncolors_sdt = maximum(sparsediff_coloring)

method = ColPack.d1_coloring()
verbose = false
@time colpack_coloring = ColPackColoring(paths[1], method, random_ordering(); verbose)

for ordering in orderings
    colpack_coloring = ColPackColoring(paths[1], method, ordering; verbose)
end

colors_colpack = get_colors(colpack_coloring)
ncolors_colpack = maximum(colors_colpack)
