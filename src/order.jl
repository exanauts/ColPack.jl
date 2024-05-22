"""
    ColoringOrder

Represent a [ColPack](https://github.com/CSCsw/ColPack)-compatible [coloring order](https://cscapes.cs.purdue.edu/coloringpage/software.htm#Ordering).

# Fields

- `order::String`

# Constructors

- [`natural_ordering()`](@ref)
- [`largest_first_ordering()`](@ref)
- [`dynamic_largest_first_ordering()`](@ref)
- [`distance_two_largest_first_ordering()`](@ref)
- [`smallest_last_ordering()`](@ref)
- [`distance_two_smallest_last_ordering()`](@ref)
- [`incidence_degree_ordering()`](@ref)
- [`distance_two_incidence_degree_ordering()`](@ref)
- [`random_ordering()`](@ref)
"""
struct ColoringOrder
    order::String
end

"""
    natural_ordering()

Shortcut for `ColoringOrder("NATURAL")`.
"""
natural_ordering() = ColoringOrder("NATURAL")

"""
    largest_first_ordering()

Shortcut for `ColoringOrder("LARGEST_FIRST")`.
"""
largest_first_ordering() = ColoringOrder("LARGEST_FIRST")

"""
    dynamic_largest_first_ordering()

Shortcut for `ColoringOrder("DYNAMIC_LARGEST_FIRST")`.
"""
dynamic_largest_first_ordering() = ColoringOrder("DYNAMIC_LARGEST_FIRST")

"""
    distance_two_largest_first_ordering()

Shortcut for `ColoringOrder("DISTANCE_TWO_LARGEST_FIRST")`.
"""
distance_two_largest_first_ordering() = ColoringOrder("DISTANCE_TWO_LARGEST_FIRST")

"""
    smallest_last_ordering()

Shortcut for `ColoringOrder("SMALLEST_LAST")`.
"""
smallest_last_ordering() = ColoringOrder("SMALLEST_LAST")

"""
    distance_two_smallest_last_ordering()

Shortcut for `ColoringOrder("DISTANCE_TWO_SMALLEST_LAST")`.
"""
distance_two_smallest_last_ordering() = ColoringOrder("DISTANCE_TWO_SMALLEST_LAST")

"""
    incidence_degree_ordering()

Shortcut for `ColoringOrder("INCIDENCE_DEGREE")`.
"""
incidence_degree_ordering() = ColoringOrder("INCIDENCE_DEGREE")

"""
    distance_two_incidence_degree_ordering()

Shortcut for `ColoringOrder("DISTANCE_TWO_INCIDENCE_DEGREE")`.
"""
distance_two_incidence_degree_ordering() = ColoringOrder("DISTANCE_TWO_INCIDENCE_DEGREE")

"""
    random_ordering()

Shortcut for `ColoringOrder("RANDOM")`.
"""
random_ordering() = ColoringOrder("RANDOM")
