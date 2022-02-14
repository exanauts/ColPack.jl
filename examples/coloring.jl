using ColPack

verbose = 1
A = sprand(100, 100, 0.1)
MatrixMarket.mmwrite(filename, A)
ccall((:hello, libcolpack), Cvoid, ())

coloring = ColPack(filename, ColPack.d1, "RANDOM", verbose)
colors = get_colors(coloring)