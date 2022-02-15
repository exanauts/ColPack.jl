using ColPack
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

push!(ncolors, 11)
push!(ncolors, 9)
push!(ncolors, 9)
push!(ncolors, 10)
push!(ncolors, 10)
push!(ncolors, 10)
push!(ncolors, 9)
push!(ncolors, 9)
# push!(ncolors, 10)

Random.seed!(2713)
A = sprand(100,100,0.1)

const filename = joinpath(@__DIR__, "A.mtx")
MatrixMarket.mmwrite(filename, A)
verbose = 1

@testset "Test ColPack" begin
    for (i,ordering) in enumerate(orderings)
        coloring = ColPackColoring(filename, ColPack.d1, ordering, verbose)
        @test length(unique(get_colors(coloring))) == ncolors[i]
    end
end