# Wrapping headers

This directory contains a script that can be used to automatically generate wrappers from C headers provided by ColPack.
This is done using Clang.jl.

# Usage

Either run `julia --project wrapper.jl` directly, or include it and call the function `main()`.
Be sure to activate the project environment in this folder (`julia --project`), which will install `Clang.jl` and `JuliaFormatter.jl`.
