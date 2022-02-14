module ColPack

using SparseArrays
using MatrixMarket

const libcolpack = "/home/michel/git/ColPack.jl/ColPack/build/automake/build/lib/libColPack"

const filename = "mat.mtx"
const d1 = "DISTANCE_ONE" 
const d2 = "DISTANCE_TWO"
const acyclic = "ACYCLIC", 
const star = "STAR", 

struct ColPack
    refColPack::Vector{Ptr{Cvoid}}
    coloring::Vector{Cint}
    method::AbstractString
    order::AbstractString
end

function ColPack(filename::AbstractString, method::AbstractString, order::AbstractString, verbose::Int)
    reflen = Vector{Cint}([Cint(0)])
    refColPack = Vector{Ptr{Cvoid}}([C_NULL])
    ret = ccall(
        (:build_coloring, libcolpack),
        Cint, (Ptr{Cvoid}, Ptr{Cint}, Cstring, Cstring, Cstring, Cint),
        refColPack, reflen, filename, method, order, verbose,
    )
    if ret == 0
        error("ColPack coloring failed.")
    end

    println("Coloring length $(reflen[1])")
    return ColPack(refColPack, zeros(Int, reflen[1]), method, order)
end

function get_colors(coloring::ColPack)
   ccall(
       (:get_colors, libcolpack),
       Cvoid, (Ptr{Cvoid}, Ptr{Cdouble}, Cstring),
       coloring.refColPack[1], coloring.coloring, coloring.method,
   )
   @show coloring.coloring
end

@show length(get_colors(coloring))
@show unique(colors)
@show length(unique(colors))
end #module

