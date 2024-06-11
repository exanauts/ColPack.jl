function build_coloring_from_file(ref, len, _filename, _method, _order, verbose)
    @ccall libcolpack.build_coloring_from_file(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        _filename::Ptr{Cchar},
        _method::Ptr{Cchar},
        _order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_partial_coloring_from_file(ref, len, _filename, _method, _order, verbose)
    @ccall libcolpack.build_partial_coloring_from_file(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        _filename::Ptr{Cchar},
        _method::Ptr{Cchar},
        _order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_bicoloring_from_file(ref, len1, len2, _filename, _method, _order, verbose)
    @ccall libcolpack.build_bicoloring_from_file(
        ref::Ptr{Ptr{Cvoid}},
        len1::Ptr{Cint},
        len2::Ptr{Cint},
        _filename::Ptr{Cchar},
        _method::Ptr{Cchar},
        _order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_coloring_from_adolc(ref, len, adolc, rowcount, _method, _order, verbose)
    @ccall libcolpack.build_coloring_from_adolc(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        adolc::Ptr{Ptr{Cuint}},
        rowcount::Cint,
        _method::Ptr{Cchar},
        _order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_partial_coloring_from_adolc(
    ref, len, adolc, rowcount, colcount, _method, _order, verbose
)
    @ccall libcolpack.build_partial_coloring_from_adolc(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        adolc::Ptr{Ptr{Cuint}},
        rowcount::Cint,
        colcount::Cint,
        _method::Ptr{Cchar},
        _order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_bicoloring_from_adolc(
    ref, len1, len2, adolc, rowcount, colcount, _method, _order, verbose
)
    @ccall libcolpack.build_bicoloring_from_adolc(
        ref::Ptr{Ptr{Cvoid}},
        len1::Ptr{Cint},
        len2::Ptr{Cint},
        adolc::Ptr{Ptr{Cuint}},
        rowcount::Cint,
        colcount::Cint,
        _method::Ptr{Cchar},
        _order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_partial_coloring_from_csr(
    ref, len, rows, cols, rowcount, colcount, _method, _order, verbose
)
    @ccall libcolpack.build_partial_coloring_from_csr(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        rows::Ptr{Cint},
        cols::Ptr{Cint},
        rowcount::Cint,
        colcount::Cint,
        _method::Ptr{Cchar},
        _order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function get_coloring(ref, coloring)
    @ccall libcolpack.get_coloring(ref::Ptr{Cvoid}, coloring::Ptr{Cint})::Cvoid
end

function get_partial_coloring(ref, coloring)
    @ccall libcolpack.get_partial_coloring(ref::Ptr{Cvoid}, coloring::Ptr{Cint})::Cvoid
end

function get_bicoloring(ref, left_coloring, right_coloring)
    @ccall libcolpack.get_bicoloring(
        ref::Ptr{Cvoid}, left_coloring::Ptr{Cint}, right_coloring::Ptr{Cint}
    )::Cvoid
end

function free_coloring(ref)
    @ccall libcolpack.free_coloring(ref::Ptr{Cvoid})::Cvoid
end

function free_partial_coloring(ref)
    @ccall libcolpack.free_partial_coloring(ref::Ptr{Cvoid})::Cvoid
end

function free_bicoloring(ref)
    @ccall libcolpack.free_bicoloring(ref::Ptr{Cvoid})::Cvoid
end
