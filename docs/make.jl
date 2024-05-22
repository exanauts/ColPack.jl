using Documenter
using ColPack

cp(joinpath(@__DIR__, "..", "README.md"), joinpath(@__DIR__, "src", "index.md"); force=true)

makedocs(;
    modules=[ColPack],
    authors="Michel Schanen",
    sitename="ColPack.jl",
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
        "Tutorial" => "tutorial.md",
        "API reference" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/michel2323/ColPack.jl",
    devbranch="master",
)
