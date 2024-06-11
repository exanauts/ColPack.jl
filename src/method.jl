"""
    ColoringMethod

Represent a [ColPack](https://github.com/CSCsw/ColPack)-compatible [coloring method](https://cscapes.cs.purdue.edu/coloringpage/software.htm#capabilities).

# Fields

- `method::String`

# Constructors

- [`d1_coloring()`](@ref)
- [`d2_coloring()`](@ref)
- [`acyclic_coloring()`](@ref)
- [`star_coloring()`](@ref)
- [`row_partial_d2_coloring()`](@ref)
- [`column_partial_d2_coloring()`](@ref)
- [`implicit_star_bicoloring()`](@ref)
- [`explicit_star_bicoloring()`](@ref)
- [`explicit_modified_star_bicoloring()`](@ref)
- [`implicit_greedy_star_bicoloring()`](@ref)
"""
struct ColoringMethod
    method::String
end

"""
    d1_coloring()

Shortcut for `ColoringMethod("DISTANCE_ONE")`.
"""
d1_coloring() = ColoringMethod("DISTANCE_ONE")

"""
    d2_coloring()

Shortcut for `ColoringMethod("DISTANCE_TWO")`.
"""
d2_coloring() = ColoringMethod("DISTANCE_TWO")

"""
    acyclic_coloring()

Shortcut for `ColoringMethod("ACYCLIC")`.
"""
acyclic_coloring() = ColoringMethod("ACYCLIC")

"""
    star_coloring()

Shortcut for `ColoringMethod("STAR")`.
"""
star_coloring() = ColoringMethod("STAR")

"""
    row_partial_d2_coloring()

Shortcut for `ColoringMethod("ROW_PARTIAL_DISTANCE_TWO")`.
"""
row_partial_d2_coloring() = ColoringMethod("ROW_PARTIAL_DISTANCE_TWO")

"""
    column_partial_d2_coloring()

Shortcut for `ColoringMethod("COLUMN_PARTIAL_DISTANCE_TWO")`.
"""
column_partial_d2_coloring() = ColoringMethod("COLUMN_PARTIAL_DISTANCE_TWO")

"""
    implicit_star_bicoloring()

Shortcut for `ColoringMethod("IMPLICIT_COVERING__STAR_BICOLORING")`.
"""
implicit_star_bicoloring() = ColoringMethod("IMPLICIT_COVERING__STAR_BICOLORING")

"""
    explicit_star_bicoloring()

Shortcut for `ColoringMethod("EXPLICIT_COVERING__STAR_BICOLORING")`.
"""
explicit_star_bicoloring() = ColoringMethod("EXPLICIT_COVERING__STAR_BICOLORING")

"""
    explicit_modified_star_bicoloring()

Shortcut for `ColoringMethod("EXPLICIT_COVERING__MODIFIED_STAR_BICOLORING")`.
"""
explicit_modified_star_bicoloring() = ColoringMethod("EXPLICIT_COVERING__MODIFIED_STAR_BICOLORING")

"""
    implicit_greedy_star_bicoloring()

Shortcut for `ColoringMethod(IMPLICIT_COVERING__GREEDY_STAR_BICOLORING")`.
"""
implicit_greedy_star_bicoloring() = ColoringMethod("IMPLICIT_COVERING__GREEDY_STAR_BICOLORING")
