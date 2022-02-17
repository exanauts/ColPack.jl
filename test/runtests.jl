using ColPack
using LinearAlgebra
using MatrixMarket
using Random
using SparseArrays
using Test

orderings = Vector{String}()

push!(orderings, "NATURAL")
push!(orderings, "LARGEST_FIRST")
push!(orderings, "DYNAMIC_LARGEST_FIRST")
push!(orderings, "DISTANCE_TWO_LARGEST_FIRST")
push!(orderings, "SMALLEST_LAST")
push!(orderings, "DISTANCE_TWO_SMALLEST_LAST")
push!(orderings, "INCIDENCE_DEGREE")
push!(orderings, "DISTANCE_TWO_INCIDENCE_DEGREE")
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
            coloring = ColPackColoring(filename, ColPack.d1, ordering; verbose=verbose)
            @test length(unique(get_colors(coloring))) == ncolors[i]
        end
    end
    @testset "Test ADOL-C Compressed Row Storage" begin
        for (i,ordering) in enumerate(orderings)
            coloring = ColPackColoring(A, ColPack.d1, ordering; verbose=verbose)
            @test length(unique(get_colors(coloring))) == ncolors[i]
        end
    end
end
