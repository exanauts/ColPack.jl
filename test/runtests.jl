using Aqua
using ColPack
using Documenter
using JET
using Test

@testset verbose = true "ColPack" begin
    @testset verbose = false "Code quality" begin
        Aqua.test_all(ColPack)
        @testset "JET" begin
            JET.test_package(ColPack; target_defined_modules=true)
        end
    end
    @testset "Doctests" begin
        Documenter.doctest(ColPack)
    end
    @testset verbose = true "Functionality" begin
        include("functionality.jl")
    end
end
