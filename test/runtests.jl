using LinearShiftRegisters
using Test

@testset "LinearShiftRegisters.jl" begin
    @test isnothing(LinearShiftRegisters._repeated_substring("1"))
    @test isnothing(LinearShiftRegisters._repeated_substring("GOLD"))
    @test isnothing(LinearShiftRegisters._repeated_substring("ajhslkjbwkb"))
    @test LinearShiftRegisters._repeated_substring("GOLDGOLDGOLDGOLD") == "GOLD"
    @test LSR_period("1001", "0100") == "001000111101011"
    @test LSR_period("1001", "0101") == "101011001000111"
    @test LSR_period([1, 0, 0, 1], [0, 1, 0, 0]) == [0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1]
    @test LSR_period([1, 0, 0, 1], [0, 1, 0, 1]) == [1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1]
    @test LinearShiftRegisters._LCG_period(9, 5, 2, 0) == [0, 2, 3, 8, 6, 5]
    @test LCG_period(9, 5, 2, 0) == "023865"
end
