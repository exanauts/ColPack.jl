using ColPack
using LinearAlgebra
using MatrixMarket
using Random
using SparseArrays
using SparseDiffTools
using StableRNGs
using Test

rng = StableRNG(63)

orderings = Vector{ColoringOrder}()

push!(orderings, natural_ordering())
push!(orderings, largest_first_ordering())
push!(orderings, dynamic_largest_first_ordering())
push!(orderings, distance_two_largest_first_ordering())
push!(orderings, smallest_last_ordering())
push!(orderings, distance_two_smallest_last_ordering())
push!(orderings, incidence_degree_ordering())
push!(orderings, distance_two_incidence_degree_ordering())
# push!(orderings, random_ordering())

ncolors = Vector{Cint}()

push!(ncolors, 7)
push!(ncolors, 7)
push!(ncolors, 6)
push!(ncolors, 7)  # changed
push!(ncolors, 6)
push!(ncolors, 6)
push!(ncolors, 6)  # changed
push!(ncolors, 6)
# push!(ncolors, 10)

Random.seed!(2713)
# Create adjacency graph
# TODO: random is a bad idea, nb of colors may change (temporarily fixed with StableRNGs)
A = convert(SparseMatrixCSC, Symmetric(sprand(rng, 100, 100, 0.1)))

const filename = joinpath(@__DIR__, "A.mtx")
MatrixMarket.mmwrite(filename, A)
verbose = false

@testset "MatrixMarket API" begin
    @testset "Coloring -- $ordering" for (i, ordering) in enumerate(orderings)
        coloring = ColPackColoring(filename, d1_coloring(), ordering; verbose=verbose)
        @test maximum(get_colors(coloring)) == ncolors[i]
    end

    @testset "Partial coloring -- $ordering" for (i, ordering) in enumerate(orderings)
        row_coloring = ColPackPartialColoring(filename, row_partial_d2_coloring(), ordering; verbose=verbose)
        column_coloring = ColPackPartialColoring(filename, column_partial_d2_coloring(), ordering; verbose=verbose)
    end
end

@testset "ADOL-C Compressed Row Storage" begin
    @testset "Coloring -- $ordering" for (i, ordering) in enumerate(orderings)
        coloring = ColPackColoring(A, d1_coloring(), ordering; verbose=verbose)
        @test maximum(get_colors(coloring)) == ncolors[i]
    end
end

@testset "CSR Storage" begin
    @testset "Partial coloring -- $ordering" for (i, ordering) in enumerate(orderings)
        row_coloring = ColPackPartialColoring(A, row_partial_d2_coloring(), ordering; verbose=verbose)
        column_coloring = ColPackPartialColoring(A, column_partial_d2_coloring(), ordering; verbose=verbose)
    end
end

@testset "ColPack Columns Coloring" begin
    A = [
        [1.0 1.0 0.0 0.0 0.0]
        [0.0 0.0 1.0 0.0 0.0]
        [0.0 1.0 0.0 1.0 0.0]
        [0.0 0.0 0.0 1.0 1.0]
    ]

    A = sparse(A)
    adjA = ColPack.matrix2adjmatrix(A; partition_by_rows=false)
    @test issymmetric(adjA)
    coloring = ColPackColoring(adjA, d1_coloring(), natural_ordering(); verbose=true)
    @test get_colors(coloring) == SparseDiffTools.matrix_colors(A)
end
