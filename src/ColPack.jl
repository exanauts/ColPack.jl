module ColPack

using ColPack_jll
using LinearAlgebra
using MatrixMarket
using SparseArrays

export ColPackColoring, get_colors, matrix2adjmatrix

abstract type AbstractColoring end
include("colorings.jl")
export AbstractColoring

abstract type AbstractOrdering end
include("orderings.jl")
export AbstractOrdering

include("utils.jl")

mutable struct ColPackColoring
    refColPack::Vector{Ptr{Cvoid}}
    coloring::Vector{Cint}
    method::AbstractColoring
    order::AbstractOrdering
    csr::Union{Vector{Ptr{Cuint}},Nothing}
end

function free_coloring(g::ColPackColoring)
    ccall(
        (:free_coloring, libcolpack),
        Cvoid, (Ptr{Cvoid},),
        g.refColPack,
    )
    return nothing
end

function ColPackColoring(filename::AbstractString, method::AbstractColoring, order::AbstractOrdering; verbose::Bool=false)
    reflen = Vector{Cint}([Cint(0)])
    refColPack = Vector{Ptr{Cvoid}}([C_NULL])
    ret = ccall(
        (:build_coloring, libcolpack),
        Cint, (Ptr{Cvoid}, Ptr{Cint}, Cstring, Cstring, Cstring, Cint),
        refColPack, reflen, filename, method.colpack_coloring, order.colpack_ordering, Cint(verbose),
    )
    if ret == 0
        error("ColPack coloring failed.")
    end

    g = ColPackColoring(refColPack, zeros(Int, reflen[1]), method, order, nothing)
    finalizer(free_coloring, g)
    return g
end

function ColPackColoring(M::SparseMatrixCSC{VT,IT}, method::AbstractColoring, order::AbstractOrdering; verbose::Bool=false) where {VT,IT}
    @assert issymmetric(M)
    csr = Vector{Ref{Cuint}}()
    for i in 1:(length(M.colptr) -1)
        vec = Vector{Cuint}()
        # Number of column elements of column elements
        push!(vec, M.colptr[i+1] - M.colptr[i])
        for j in M.colptr[i]:(M.colptr[i+1]-1)
            push!(vec, M.rowval[j]-1)
        end
        push!(csr, Base.unsafe_convert(Ptr{Cuint}, vec))
    end
    nrows = size(M,2) 
    reflen = Vector{Cint}([Cint(0)])
    refColPack = Vector{Ptr{Cvoid}}([C_NULL])
    ret = ccall(
        (:build_coloring_from_csr, libcolpack),
        Cint, (Ptr{Cvoid}, Ptr{Cint}, Ref{Ptr{Cuint}}, Cint, Cstring, Cstring, Cint),
        refColPack, reflen, csr, nrows, method.colpack_coloring, order.colpack_ordering, Cint(verbose),
    )
    if ret == 0
        error("ColPack coloring failed.")
    end

    g = ColPackColoring(refColPack, zeros(Int, reflen[1]), method, order, csr)
    finalizer(free_coloring, g)
    return g
end

function get_colors(coloring::ColPackColoring; verbose=false)
   ccall(
       (:get_colors, libcolpack),
       Cvoid, (Ptr{Cvoid}, Ptr{Cdouble}, Cstring, Cint),
       coloring.refColPack[1], coloring.coloring, coloring.method.colpack_coloring, Cint(verbose)
   )
   # Julia colorings should be base 1
   return coloring.coloring .+ 1
end
end #module
