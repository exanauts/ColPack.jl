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

method = row_partial_d2_coloring()
@time colpack_partial_coloring1 = ColPackPartialColoring(paths[1], method, natural_ordering(); verbose)
colors_row = get_colors(colpack_partial_coloring1)
maximum(colors_row)

method = column_partial_d2_coloring()
@time colpack_partial_coloring2 = ColPackPartialColoring(paths[1], method, natural_ordering(); verbose)
colors_column = get_colors(colpack_partial_coloring2)
maximum(colors_column)

method = row_partial_d2_coloring()
@time colpack_partial_coloring1 = ColPackPartialColoring(A, method, natural_ordering(); verbose)
colors_row2 = get_colors(colpack_partial_coloring1)
maximum(colors_row2)

method = column_partial_d2_coloring()
@time colpack_partial_coloring2 = ColPackPartialColoring(A, method, natural_ordering(); verbose)
colors_column2 = get_colors(colpack_partial_coloring2)
maximum(colors_column2)

method = implicit_star_bicoloring()
# method = explicit_star_bicoloring()
# method = explicit_modified_star_bicoloring()
# method = implicit_greedy_star_bicoloring()
@time colpack_bicoloring = ColPackBiColoring(paths[1], method, random_ordering(); verbose)
colors1, colors2 = get_colors(colpack_bicoloring)
