function build_coloring_from_file(ref, len, filename, method, order, verbose)
    @ccall libcolpack.build_coloring_from_file(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        filename::Ptr{Cchar},
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_partial_coloring_from_file(ref, len, filename, method, order, verbose)
    @ccall libcolpack.build_partial_coloring_from_file(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        filename::Ptr{Cchar},
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_bicoloring_from_file(ref, len1, len2, filename, method, order, verbose)
    @ccall libcolpack.build_bicoloring_from_file(
        ref::Ptr{Ptr{Cvoid}},
        len1::Ptr{Cint},
        len2::Ptr{Cint},
        filename::Ptr{Cchar},
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_coloring_from_adolc(ref, len, adolc, nrows, method, order, verbose)
    @ccall libcolpack.build_coloring_from_adolc(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        adolc::Ptr{Ptr{Cuint}},
        nrows::Cint,
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_partial_coloring_from_adolc(
    ref, len, adolc, nrows, ncols, method, order, verbose
)
    @ccall libcolpack.build_partial_coloring_from_adolc(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        adolc::Ptr{Ptr{Cuint}},
        nrows::Cint,
        ncols::Cint,
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_bicoloring_from_adolc(
    ref, len1, len2, adolc, nrows, ncols, method, order, verbose
)
    @ccall libcolpack.build_bicoloring_from_adolc(
        ref::Ptr{Ptr{Cvoid}},
        len1::Ptr{Cint},
        len2::Ptr{Cint},
        adolc::Ptr{Ptr{Cuint}},
        nrows::Cint,
        ncols::Cint,
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_partial_coloring_from_csr(
    ref, len, rowptr, colval, nrows, ncols, method, order, verbose
)
    @ccall libcolpack.build_partial_coloring_from_csr(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        rowptr::Ptr{Cint},
        colval::Ptr{Cint},
        nrows::Cint,
        ncols::Cint,
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_bicoloring_from_csr(
    ref, len1, len2, rowptr, colval, nrows, ncols, method, order, verbose
)
    @ccall libcolpack.build_bicoloring_from_csr(
        ref::Ptr{Ptr{Cvoid}},
        len1::Ptr{Cint},
        len2::Ptr{Cint},
        rowptr::Ptr{Cint},
        colval::Ptr{Cint},
        nrows::Cint,
        ncols::Cint,
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_partial_coloring_from_csc(
    ref, len, rowval, colptr, nrows, ncols, method, order, verbose
)
    @ccall libcolpack.build_partial_coloring_from_csc(
        ref::Ptr{Ptr{Cvoid}},
        len::Ptr{Cint},
        rowval::Ptr{Cint},
        colptr::Ptr{Cint},
        nrows::Cint,
        ncols::Cint,
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function build_bicoloring_from_csc(
    ref, len1, len2, rowval, colptr, nrows, ncols, method, order, verbose
)
    @ccall libcolpack.build_bicoloring_from_csc(
        ref::Ptr{Ptr{Cvoid}},
        len1::Ptr{Cint},
        len2::Ptr{Cint},
        rowval::Ptr{Cint},
        colptr::Ptr{Cint},
        nrows::Cint,
        ncols::Cint,
        method::Ptr{Cchar},
        order::Ptr{Cchar},
        verbose::Cint,
    )::Cint
end

function order_coloring(ref, ordering)
    @ccall libcolpack.order_coloring(ref::Ptr{Cvoid}, ordering::Ptr{Cint})::Cvoid
end

function order_partial_coloring(ref, ordering)
    @ccall libcolpack.order_partial_coloring(ref::Ptr{Cvoid}, ordering::Ptr{Cint})::Cvoid
end

function order_bicoloring(ref, ordering)
    @ccall libcolpack.order_bicoloring(ref::Ptr{Cvoid}, ordering::Ptr{Cint})::Cvoid
end

function timer_order_coloring(ref)
    @ccall libcolpack.timer_order_coloring(ref::Ptr{Cvoid})::Cdouble
end

function timer_order_partial_coloring(ref)
    @ccall libcolpack.timer_order_partial_coloring(ref::Ptr{Cvoid})::Cdouble
end

function timer_order_bicoloring(ref)
    @ccall libcolpack.timer_order_bicoloring(ref::Ptr{Cvoid})::Cdouble
end

function colors_coloring(ref, coloring)
    @ccall libcolpack.colors_coloring(ref::Ptr{Cvoid}, coloring::Ptr{Cint})::Cvoid
end

function colors_partial_coloring(ref, coloring)
    @ccall libcolpack.colors_partial_coloring(ref::Ptr{Cvoid}, coloring::Ptr{Cint})::Cvoid
end

function colors_bicoloring(ref, left_coloring, right_coloring)
    @ccall libcolpack.colors_bicoloring(
        ref::Ptr{Cvoid}, left_coloring::Ptr{Cint}, right_coloring::Ptr{Cint}
    )::Cvoid
end

function timer_colors_coloring(ref)
    @ccall libcolpack.timer_colors_coloring(ref::Ptr{Cvoid})::Cdouble
end

function timer_colors_partial_coloring(ref)
    @ccall libcolpack.timer_colors_partial_coloring(ref::Ptr{Cvoid})::Cdouble
end

function timer_colors_bicoloring(ref)
    @ccall libcolpack.timer_colors_bicoloring(ref::Ptr{Cvoid})::Cdouble
end

function ncolors_coloring(ref)
    @ccall libcolpack.ncolors_coloring(ref::Ptr{Cvoid})::Cint
end

function ncolors_partial_coloring(ref)
    @ccall libcolpack.ncolors_partial_coloring(ref::Ptr{Cvoid})::Cint
end

function ncolors_bicoloring(ref)
    @ccall libcolpack.ncolors_bicoloring(ref::Ptr{Cvoid})::Cint
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
