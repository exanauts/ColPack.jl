module ColPack

using SparseArrays
using MatrixMarket
using ColPack_jll

export ColPackColoring, get_colors

const d1 = "DISTANCE_ONE" 
const d2 = "DISTANCE_TWO"
const acyclic = "ACYCLIC", 
const star = "STAR", 

struct ColPackColoring
    refColPack::Vector{Ptr{Cvoid}}
    coloring::Vector{Cint}
    method::AbstractString
    order::AbstractString
    csr::Union{Vector{Ptr{Cuint}},Nothing}
end

function ColPackColoring(filename::AbstractString, method::AbstractString, order::AbstractString, verbose::Int)
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

    # println("Coloring length $(reflen[1])")
    return ColPackColoring(refColPack, zeros(Int, reflen[1]), method, order, nothing)
end

function ColPackColoring(M_::SparseMatrixCSC{VT,IT}, method::AbstractString, order::AbstractString, verbose::Int) where {VT,IT}
    # Get the CSR by transposing
    # M = convert(SparseMatrixCSC, transpose(M_))
    M = M_
    csr = Vector{Ref{Cuint}}()
    @show length(M.colptr)
    @show length(M.rowval)
    @show length(M.nzval)
    @show size(M)
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
    # @assert nrows == size(M,2)
    reflen = Vector{Cint}([Cint(0)])
    refColPack = Vector{Ptr{Cvoid}}([C_NULL])
    ret = ccall(
        (:build_coloring_from_csr, libcolpack),
        Cint, (Ptr{Cvoid}, Ptr{Cint}, Ref{Ptr{Cuint}}, Cint, Cstring, Cstring, Cint),
        refColPack, reflen, csr, nrows, method, order, verbose,
    )
    # exit()
    if ret == 0
        error("ColPack coloring failed.")
    end

    println("Coloring length $(reflen[1])")
    return ColPackColoring(refColPack, zeros(Int, reflen[1]), method, order, csr)
end

function get_colors(coloring::ColPackColoring)
   ccall(
       (:get_colors, libcolpack),
       Cvoid, (Ptr{Cvoid}, Ptr{Cdouble}, Cstring),
       coloring.refColPack[1], coloring.coloring, coloring.method,
   )
   return coloring.coloring
end
end #module

