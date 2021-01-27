include(joinpath(dirname(@__DIR__), "src", "LinearShiftRegisters.jl"))
using Documenter, .LinearShiftRegisters

Documenter.makedocs(
    clean = true,
    doctest = true,
    modules = Module[LinearShiftRegisters],
    repo = "",
    highlightsig = true,
    sitename = "LinearShiftRegisters Documentation",
    expandfirst = [],
    pages = [
        "Index" => "index.md",
    ]
)

deploydocs(;
    repo  =  "github.com/jakewilliami/LinearShiftRegisters.jl.git",
)
