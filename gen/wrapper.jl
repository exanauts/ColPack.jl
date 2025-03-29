# Script to parse CUTEst headers and generate Julia wrappers.
using ColPack_jll
using Clang
using Clang.Generators
using JuliaFormatter

# Add cinterface.h in the next release of ColPack_jll.jl!
function main()
  cd(@__DIR__)
  include_dir = joinpath(ColPack_jll.artifact_dir, "include")
  # headers = joinpath(include_dir, "cinterface.h")
  headers = joinpath("..", "..", "ColPack", "src", "Utilities", "cinterface.h")

  options = load_options(joinpath(@__DIR__, "colpack.toml"))
  options["general"]["output_file_path"] = joinpath("..", "src", "libcolpack.jl")
  options["general"]["output_ignorelist"] = []

  args = get_default_args()
  push!(args, "-I$include_dir")

  ctx = create_context(headers, args, options)
  build!(ctx)

  path = options["general"]["output_file_path"]
  format_file(path, YASStyle())
  return nothing
end

# If we want to use the file as a script with `julia wrapper.jl`
if abspath(PROGRAM_FILE) == @__FILE__
  main()
end
