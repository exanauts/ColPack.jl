"""
	colpack(file::String, method::String, order::String; verbose::Bool=false, threading::Bool=false)

Perform graph coloring with the [ColPack executable](https://github.com/CSCsw/ColPack?tab=readme-ov-file#usage).

- `file`: Indicates the graph file path.
- `method`: Indicates the method.
- `order`: Indicates the ordering.
- `verbose`: Indicates verbose flag will be turned on and there will display more rich information.
- `nthreads`: Indicates the number of threads (defaults to 1)

# Examples

    colpack("./bcsstk01.mtx", "DISTANCE_ONE", "RANDOM", verbose=true)
    colpack("./bcsstk01.mtx", "ROW_PARTIAL_DISTANCE_TWO", "NATURAL", verbose=true)
    colpack("./bcsstk01.mtx", "COLUMN_PARTIAL_DISTANCE_TWO", "NATURAL", verbose=true, nthreads::Int=1)
"""
function colpack(
    file::String, method::String, order::String; verbose::Bool=false, nthreads::Int=1
)
    if verbose
        run(`$(ColPack_jll.ColPack()) -f $file -m $method -o $order -nT $nthreads -v`)
    else
        run(`$(ColPack_jll.ColPack()) -f $file -m $method -o $order -nT $nthreads`)
    end
end
