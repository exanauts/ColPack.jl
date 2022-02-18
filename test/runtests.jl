using ColPack
using LinearAlgebra
using MatrixMarket
using Random
using SparseArrays
using Test

orderings = Vector{AbstractOrdering}()

push!(orderings, natural_ordering())
push!(orderings, largest_first_ordering())
push!(orderings, dynamic_largest_first_ordering())
push!(orderings, distance_two_largest_first_ordering())
push!(orderings, smallest_last_ordering())
push!(orderings, distance_two_smallest_last_ordering())
push!(orderings, incidence_degree_ordering())
push!(orderings, distance_two_incidence_degree_ordering())
# push!(orderings, "RANDOM")

ncolors = Vector{Int}()

push!(ncolors, 7)
push!(ncolors, 7)
push!(ncolors, 6)
push!(ncolors, 6)
push!(ncolors, 6)
push!(ncolors, 6)
push!(ncolors, 7)
push!(ncolors, 6)
# push!(ncolors, 10)

Random.seed!(2713)
# Create adjacency graph
A = convert(SparseMatrixCSC, Symmetric(sprand(100,100,0.1)))

const filename = joinpath(@__DIR__, "A.mtx")
MatrixMarket.mmwrite(filename, A)
verbose = false

@testset "Test ColPack" begin
    @testset "Test Matrix Market API" begin
        for (i,ordering) in enumerate(orderings)
            coloring = ColPackColoring(filename, d1_coloring(), ordering; verbose=verbose)
            @test length(unique(get_colors(coloring))) == ncolors[i]
        end
    end
    @testset "Test ADOL-C Compressed Row Storage" begin
        for (i,ordering) in enumerate(orderings)
            coloring = ColPackColoring(A, d1_coloring(), ordering; verbose=verbose)
            @test length(unique(get_colors(coloring))) == ncolors[i]
        end
    end
end
