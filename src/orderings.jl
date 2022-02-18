struct natural_ordering <: AbstractOrdering
    colpack_ordering::String
end 
natural_ordering() = natural_ordering("NATURAL")

struct largest_first_ordering <: AbstractOrdering
    colpack_ordering::String
end
largest_first_ordering() = largest_first_ordering("LARGEST_FIRST")

struct dynamic_largest_first_ordering <: AbstractOrdering
    colpack_ordering::String
end
dynamic_largest_first_ordering() = dynamic_largest_first_ordering("DYNAMIC_LARGEST_FIRST")

struct distance_two_largest_first_ordering <: AbstractOrdering
    colpack_ordering::String
end
distance_two_largest_first_ordering() = distance_two_largest_first_ordering("DISTANCE_TWO_LARGEST_FIRST")

struct smallest_last_ordering <: AbstractOrdering
    colpack_ordering::String
end
smallest_last_ordering() = smallest_last_ordering("SMALLEST_LAST")

struct distance_two_smallest_last_ordering <: AbstractOrdering
    colpack_ordering::String
end
distance_two_smallest_last_ordering() = distance_two_smallest_last_ordering("DISTANCE_TWO_SMALLEST_LAST")

struct incidence_degree_ordering <: AbstractOrdering
    colpack_ordering::String
end
incidence_degree_ordering() = incidence_degree_ordering("INCIDENCE_DEGREE")

struct distance_two_incidence_degree_ordering <: AbstractOrdering
    colpack_ordering::String
end
distance_two_incidence_degree_ordering() = distance_two_incidence_degree_ordering("DISTANCE_TWO_INCIDENCE_DEGREE")

export natural_ordering, largest_first_ordering, dynamic_largest_first_ordering, distance_two_largest_first_ordering
export smallest_last_ordering, distance_two_smallest_last_ordering, incidence_degree_ordering, distance_two_incidence_degree_ordering
