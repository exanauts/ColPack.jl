using ColPack
using ColPack: ColPackBiColoring
using ColPack: COLORING_METHODS, PARTIAL_COLORING_METHODS, BICOLORING_METHODS
using ColPack: COLORING_ORDERS, PARTIAL_COLORING_ORDERS, BICOLORING_ORDERS
using LinearAlgebra
using MatrixMarket
using Random
using SparseArrays
using SparseMatrixColorings:
    directly_recoverable_columns,
    structurally_orthogonal_columns,
    symmetrically_orthogonal_columns
using StableRNGs
using Test

rng = StableRNG(62)

samples = 100

asymmetric_params = vcat(
    [(10, 20, p) for p in (0.0:0.2:1.0)],  #
    [(20, 10, p) for p in (0.0:0.2:1.0)],
    [(100, 200, p) for p in (0.01:0.02:0.05)],  #
    [(200, 100, p) for p in (0.01:0.02:0.05)],
)

symmetric_params = vcat(
    [(10, p) for p in (0.0:0.2:1.0)], #
    [(100, p) for p in (0.01:0.02:0.05)],
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
    if method in ["STAR", "COLUMN_PARTIAL_DISTANCE_TWO", "ROW_PARTIAL_DISTANCE_TWO"]
        if method == "STAR"
            @test directly_recoverable_columns(A, colors; verbose=true)
            @test symmetrically_orthogonal_columns(A, colors; verbose=true)
        elseif method == "COLUMN_PARTIAL_DISTANCE_TWO"
            @test directly_recoverable_columns(A, colors; verbose=true)
            @test structurally_orthogonal_columns(A, colors; verbose=true)
        elseif method == "ROW_PARTIAL_DISTANCE_TWO"
            @test directly_recoverable_columns(transpose(A), colors; verbose=true)
            @test structurally_orthogonal_columns(transpose(A), colors; verbose=true)
        end
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
        @testset "(n, p) = $((n, p))" for (n, p) in symmetric_params
            for _ in 1:samples
                H = sparse(Symmetric(sprand(rng, Bool, n, n, p)))
                filename = joinpath(@__DIR__, "H.mtx")
                MatrixMarket.mmwrite(filename, H)
                for order in COLORING_ORDERS
                    coloring_mat = ColPackColoring(H, method, order; verbose=false)
                    coloring_file = ColPackColoring(filename, method, order; verbose=false)
                    @test get_colors(coloring_mat) == get_colors(coloring_file)
                    test_colors(H, method, get_colors(coloring_file))
                    test_colors(H, method, get_colors(coloring_mat))
                end
            end
        end
    end
end;

@testset verbose = true "Bipartite graph partial coloring" begin
    @testset "$method" for method in PARTIAL_COLORING_METHODS
        @testset "(n, m, p) = $((n, m, p))" for (n, m, p) in asymmetric_params
            for _ in 1:samples
                J = sprand(rng, Bool, n, m, p)
                filename = joinpath(@__DIR__, "J.mtx")
                MatrixMarket.mmwrite(filename, J)
                for order in PARTIAL_COLORING_ORDERS
                    coloring_mat = ColPackPartialColoring(J, method, order; verbose=false)
                    coloring_file = ColPackPartialColoring(
                        filename, method, order; verbose=false
                    )
                    @test length(get_colors(coloring_mat)) ==
                        length(get_colors(coloring_file))
                    # this should be true but it isn't at the moment
                    @test_skip get_colors(coloring_mat) == get_colors(coloring_file)
                    test_colors(J, method, get_colors(coloring_file))
                    test_colors(J, method, get_colors(coloring_mat))
                end
            end
        end
    end
end;

@testset verbose = true "Bipartite graph bicoloring" begin
    @testset "$method" for method in BICOLORING_METHODS
        @testset "(n, m, p) = $((n, m, p))" for (n, m, p) in asymmetric_params
            for _ in 1:samples
                J = sprand(rng, Bool, n, m, p)
                filename = joinpath(@__DIR__, "J.mtx")
                MatrixMarket.mmwrite(filename, J)
                for order in BICOLORING_ORDERS
                    coloring_file = ColPackBiColoring(
                        filename, method, order; verbose=false
                    )
                    colors1, colors2 = get_colors(coloring_file)
                    test_colors(J, method, colors1, colors2)
                end
            end
        end
    end
end;
