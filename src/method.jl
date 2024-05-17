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
