"""
	colpack(file::String, method::String, order::String; verbose::Bool=false)

Perform graph coloring.

- `file`: Indicates the graph file path.
- `method`: Indicates the method.
- `order`: Indicates the ordering.
- `verbose`: Indicates verbose flag will be turned on and there will display more rich information.

Examples:
colpack("./bcsstk01.mtx", "DISTANCE_ONE", "RANDOM", verbose=true)
colpack("./bcsstk01.mtx", "ROW_PARTIAL_DISTANCE_TWO", "NATURAL", verbose=true)
colpack("./bcsstk01.mtx", "COLUMN_PARTIAL_DISTANCE_TWO", "NATURAL", verbose=true)
"""
function colpack(file::String, method::String, order::String; verbose::Bool=false)
	if verbose
		run(`$(ColPack_jll.ColPack()) -f $file -m $method -o $order -v`)
	else
		run(`$(ColPack_jll.ColPack()) -f $file -m $method -o $order`)
	end
end
