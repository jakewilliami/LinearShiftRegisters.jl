module LinearShiftRegisters

export LSR_period, LCG_period

function _repeated_substring(source)
	len = length(source)
	
	# had to account for weird edge case in which length 2 vectors always returns themselves
	if len < 3
		len == 1 && return nothing
	
		s1, s2 = source
		if len == 2 && s1 == s2
			return s1
		else
			return nothing
		end
	end
	
	# Check candidate strings
	for i in 1:(len ÷ 2 + 1)
		repeat_count, remainder = divrem(len, i)
		
		# Check for no leftovers characters, and equality when repeated
		if remainder == 0 && source == repeat(source[1:i], repeat_count)
			return source[1:i]#, repeat_count
		end
	end
	
	return nothing
end

function _LSR_period(const_vec::AbstractVector, init_vec::AbstractVector)
	sequence_vec = reverse(init_vec)

	res = nothing
	while isnothing(res)
		new_val = mod(sum(map(i -> const_vec[i] * sequence_vec[end - (i - 1)], 1:4)), 2)
		push!(sequence_vec, new_val)
		res = _repeated_substring(sequence_vec)
	end
	
	return res
end

"""
```julia
LSR_period(const_str::AbstractVector{T}, init_str::AbstractVector{R}) where {T, R <: Integer}
LSR_period(const_str::AbstractString, init_str::AbstractString)
```

Given
"""
function LSR_period(const_vec::AbstractVector{T}, init_vec::AbstractVector{R}) where {T, R <: Integer}
	return _LSR_period(const_vec, init_vec)
end
function LSR_period(const_str::AbstractString, init_str::AbstractString)
	const_vec = parse.(Int8, collect(const_str))
	init_vec = parse.(Int8, collect(init_str))
	
	return join(_LSR_period(const_vec, init_vec))
end

function _LCG_period(m::Integer, a::Integer, b::Integer, x0::T) where {T <: Integer}
	sequence_vec = T[x0]

	new_x, res = x0, nothing
	while isnothing(res)
		new_x =  mod(a * new_x + b, m)
		push!(sequence_vec, new_x)
		res = _repeated_substring(sequence_vec)
	end

	return res
end

@doc raw"""
Choose m, a positive integer.  Choose a, b (mod m) integers.

The Linear Congruential Generator is given to us by

```math
x_{n + 1} = ax_n + b \mod m.
```
"""
function LCG_period(m::Integer, a::Integer, b::Integer, x0::T) where {T <: Integer}
	return join(_LCG_period(m, a, b, x0))
end

end # end module
