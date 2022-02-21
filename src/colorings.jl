struct d1_coloring <: AbstractColoring 
    colpack_coloring::String
end 

struct d2_coloring <: AbstractColoring 
    colpack_coloring::String
end

struct acyclic_coloring <: AbstractColoring 
    colpack_coloring::String
end

struct star_coloring <: AbstractColoring 
    colpack_coloring::String
end

d1_coloring() = d1_coloring("DISTANCE_ONE") 
d2_coloring()= d2_coloring("DISTANCE_TWO")
acyclic_coloring() = acyclic_coloring("ACYCLIC") 
star_coloring() = star_coloring("STAR") 

COLORINGS = [
    d1_coloring(),
    d2_coloring(),
    acyclic_coloring(),
    star_coloring()
]

export COLORINGS
export d1_coloring, d2_coloring, acyclic_coloring, star_coloring
