function csr_to_adolc(M::SparseMatrixCSC)
    adolc = Vector{Ref{Cuint}}()
    adolc_mem = Vector{Vector{Cuint}}()
    for i in 1:(length(M.colptr) - 1)
        vec = Vector{Cuint}()
        # Number of column elements
        push!(vec, Cuint(M.colptr[i + 1] - M.colptr[i]))
        for j in M.colptr[i]:(M.colptr[i + 1] - 1)
            push!(vec, Cuint(M.rowval[j] - 1))
        end
        push!(adolc, Base.unsafe_convert(Ptr{Cuint}, vec))
        push!(adolc_mem, vec)
    end
    return adolc, adolc_mem
end
