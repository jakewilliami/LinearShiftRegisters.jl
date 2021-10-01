using LinearShiftRegisters
using BenchmarkTools

println("Benchmarking `LSR_period(::String, ::String)`")
@btime LSR_period("1001", "0100") # == "001000111101011"
@btime LSR_period("1001", "0101") # == "101011001000111"

println("Benchmarking `LSR_period(::Vector{Integer}, ::Vector{Integer})`")
@btime LSR_period([1, 0, 0, 1], [0, 1, 0, 0]) # == [0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1]
@btime LSR_period([1, 0, 0, 1], [0, 1, 0, 1]) # == [1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1]

println("Benchmarking `_LCG_period(::Integer, ::Integer, ::Integer, ::Intger)` (producing a vectorised output)")
@btime LinearShiftRegisters._LCG_period(9, 5, 2, 0) # == [0, 2, 3, 8, 6, 5]

println("Benchmarking `LCG_period(::Integer, ::Integer, ::Integer, ::Intger)` (producing a string; the main interface)")
@btime LCG_period(9, 5, 2, 0) # == "023865"

#=
Benchmarking `LSR_period(::String, ::String)`
  17.872 μs (224 allocations: 19.98 KiB)
  17.829 μs (224 allocations: 19.98 KiB)
Benchmarking `LSR_period(::Vector{Integer}, ::Vector{Integer})`
  15.694 μs (187 allocations: 30.33 KiB)
  15.670 μs (187 allocations: 30.33 KiB)
Benchmarking `_LCG_period(::Integer, ::Integer, ::Integer, ::Intger)` (producing a vectorised output)
  3.640 μs (49 allocations: 5.89 KiB)
Benchmarking `LCG_period(::Integer, ::Integer, ::Integer, ::Intger)` (producing a string; the main interface)
  4.282 μs (65 allocations: 6.64 KiB)
=#
