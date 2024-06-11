using ColPack
using ColPack: ColPackBiColoring
using SparseArrays
using Test

J_dense = [1 0 1; 0 1 0]
H_dense = [1 0; 0 1]
J = sparse(J_dense)
H = sparse(H_dense)

## No errors in normal case

@test get_colors(ColPackColoring(H, "STAR", "NATURAL")) isa Vector{Int32}
@test get_colors(ColPackPartialColoring(J, "COLUMN_PARTIAL_DISTANCE_TWO", "NATURAL")) isa
    Vector{Int32}
@test_broken get_colors(
    ColPackBiColoring(J, "EXPLICIT_COVERING__STAR_BICOLORING", "NATURAL")
) isa NTuple{Vector{Int32},2}

## Error on dense matrix

@test_throws MethodError ColPackColoring(H_dense, "STAR", "NATURAL")
@test_throws MethodError ColPackPartialColoring(
    J_dense, "COLUMN_PARTIAL_DISTANCE_TWO", "NATURAL"
)
@test_throws MethodError ColPackBiColoring(
    J_dense, "EXPLICIT_COVERING__STAR_BICOLORING", "NATURAL"
)

## Error on non-existent method

@test_throws ArgumentError ColPackColoring(H, "STARDEW_VALLEY", "NATURAL")
@test_throws ArgumentError ColPackPartialColoring(J, "NEWSPAPER_COLUMNIST", "NATURAL")

## Error on non-existent order

@test_throws ArgumentError ColPackColoring(H, "STAR", "UNNATURAL")
@test_throws ArgumentError ColPackPartialColoring(
    J, "COLUMN_PARTIAL_DISTANCE_TWO", "SUPERNATURAL"
)

## Error on non-square

@test_throws DimensionMismatch ColPackColoring(J, "STAR", "NATURAL")
