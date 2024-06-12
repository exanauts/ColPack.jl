using ColPack
using ColPack: ColPackBiColoring
using ColPack: COLORING_METHODS, PARTIAL_COLORING_METHODS, BICOLORING_METHODS
using ColPack: COLORING_ORDERS, PARTIAL_COLORING_ORDERS, BICOLORING_ORDERS
using LinearAlgebra
using MatrixMarket
using Random
using SparseArrays
using StableRNGs
using Test

rng = StableRNG(63)

asymmetric_params = vcat(
    [(10, 20, p) for p in (0.0:0.1:1.0)],  #
    [(20, 10, p) for p in (0.0:0.1:1.0)],
    [(100, 200, p) for p in (0.01:0.01:0.05)],  #
    [(200, 100, p) for p in (0.01:0.01:0.05)],
)

symmetric_params = vcat(
    [(10, p) for p in (0.0:0.1:1.0)], #
    [(100, p) for p in (0.01:0.01:0.05)],
)

function test_colors(A::AbstractMatrix, method::String, colors::AbstractVector{<:Integer})
    @test minimum(colors) >= 1
    if occursin("COLUMN", method)
        @test length(colors) == size(A, 2)
        @test maximum(colors) <= size(A, 2)
    elseif occursin("ROW", method)
        @test length(colors) == size(A, 1)
        @test maximum(colors) <= size(A, 1)
    else
        @test issymmetric(A)
        @test maximum(colors) <= size(A, 1)
    end
end

function test_colors(
    A::AbstractMatrix,
    method::String,
    colors1::AbstractVector{<:Integer},
    colors2::AbstractVector{<:Integer},
)
    #=
    I don't know yet what the indices of colors1 and colors2 mean (especially the extremal ones).
    This makes it hard to test it properly.
    =#
    @test length(colors1) <= size(A, 1)
    @test length(colors2) <= size(A, 2)
    @test isempty(intersect(Set(colors1), Set(colors2)))
end

@testset verbose = true "General graph coloring" begin
    @testset "$method" for method in COLORING_METHODS
        @testset "$order" for order in COLORING_ORDERS
            @testset "(n, p) = $((n, p))" for (n, p) in symmetric_params
                H = sparse(Symmetric(sprand(rng, Bool, n, n, p)))
                filename = joinpath(@__DIR__, "H.mtx")
                MatrixMarket.mmwrite(filename, H)
                coloring_mat = ColPackColoring(H, method, order; verbose=false)
                coloring_file = ColPackColoring(filename, method, order; verbose=false)
                @test get_colors(coloring_mat) == get_colors(coloring_file)
                colors = get_colors(coloring_file)
                test_colors(H, method, colors)
            end
        end
    end
end;

@testset verbose = true "Bipartite graph partial coloring" begin
    @testset "$method" for method in PARTIAL_COLORING_METHODS
        @testset "$order" for order in PARTIAL_COLORING_ORDERS
            @testset "(n, m, p) = $((n, m, p))" for (n, m, p) in asymmetric_params
                J = sprand(rng, Bool, n, m, p)
                filename = joinpath(@__DIR__, "J.mtx")
                MatrixMarket.mmwrite(filename, J)
                coloring_mat = ColPackPartialColoring(J, method, order; verbose=false)
                coloring_file = ColPackPartialColoring(
                    filename, method, order; verbose=false
                )
                @test length(get_colors(coloring_mat)) == length(get_colors(coloring_file))
                # this is not always true since we use different algorithms
                # @test get_colors(coloring_mat) == get_colors(coloring_file)
                test_colors(J, method, get_colors(coloring_mat))
                test_colors(J, method, get_colors(coloring_file))
            end
        end
    end
end;

@testset verbose = true "Bipartite graph bicoloring" begin
    @testset "$method" for method in BICOLORING_METHODS
        @testset "$order" for order in BICOLORING_ORDERS[1:1]
            @testset "(n, m, p) = $((n, m, p))" for (n, m, p) in asymmetric_params
                J = sprand(rng, Bool, n, m, p)
                filename = joinpath(@__DIR__, "J.mtx")
                MatrixMarket.mmwrite(filename, J)
                coloring_file = ColPackBiColoring(filename, method, order; verbose=false)
                colors1, colors2 = get_colors(coloring_file)
                test_colors(J, method, colors1, colors2)
            end
        end
    end
end;
