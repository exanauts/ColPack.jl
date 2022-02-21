"""
        _cols_by_rows(rows_index,cols_index)
Returns a vector of rows where each row contains
a vector of its column indices.
"""
function _cols_by_rows(rows_index,cols_index)
    nrows = maximum(rows_index)
    cols_by_rows = [eltype(rows_index)[] for _ in 1:nrows]
    for (i,j) in zip(rows_index,cols_index)
        push!(cols_by_rows[i],j)
    end
    return cols_by_rows
end


"""
        _rows_by_cols(rows_index,cols_index)
Returns a vector of columns where each column contains
a vector of its row indices.
"""
function _rows_by_cols(rows_index,cols_index)
    return _cols_by_rows(cols_index,rows_index)
end

function matrix2adjmatrix(M; partition_by_rows = true)
    (rows_index, cols_index, _) = findnz(M)
    if partition_by_rows
        A = SparseMatrixCSC{Float64, Cuint}(size(M,1), size(M,1), ones(Cuint, size(M,1)+1), Vector{Cuint}(), Vector{Float64}())
        rows_by_cols = _rows_by_cols(rows_index,cols_index)
        @inbounds for (cur_row,cur_col) in zip(rows_index,cols_index)
            if !isempty(rows_by_cols[cur_col])
                for next_row in rows_by_cols[cur_col]
                    if next_row < cur_row 
                        A[cur_row, next_row] = 1.0
                        A[next_row, cur_row] = 1.0
                    end
                end
            end
        end
    else
        A = SparseMatrixCSC{Float64, Cuint}(size(M,2), size(M,2), ones(Cuint, size(M,2)+1), Vector{Cuint}(), Vector{Float64}())
        cols_by_rows = _cols_by_rows(rows_index,cols_index)
        @inbounds for (cur_row,cur_col) in zip(rows_index,cols_index)
            if !isempty(cols_by_rows[cur_row])
                for next_col in cols_by_rows[cur_row]
                    if next_col < cur_col 
                        A[cur_col, next_col] = 1.0
                        A[next_col, cur_col] = 1.0
                    end
                end
            end
        end
    end
    return A
end
