# Day 1 - https://adventofcode.com/2018/day/1

using DelimitedFiles

function parseInput(filename::String)
	return readdlm(filename, Int)
end

lines = parseInput("day1.input")

# part 1

"""
	addFrequencies(lines::Array{Int64,2})

This function adds all the frequency changes.
"""
function addFrequencies(lines::Array{Int64,2})
	return sum(lines)
end

println("Resulting frequency: ", addFrequencies(lines))

# part 2

"""
	addFrequenciesAndFindDuplicate(lines::Array{String,1})

Here the integers array (`frequencies`) is used to store all values.
Each time a new frequency is computed, a search is done on the 
stored value to check if it has already been seen.
The values parsing-checking-and-appending is done as long as a 
duplicate in `frequencies` is found.
"""
function addFrequenciesAndFindDuplicate(lines::Array{Int64,2})
	c = 0
	frequencies = Set([c])
	len_freq = length(frequencies)
	while true
		for i = 1:length(lines)
			c += lines[i]
			push!(frequencies, c)
			if length(frequencies) == len_freq
				return c
			else
				len_freq = length(frequencies)
			end
		end
	end
end

twice_f = addFrequenciesAndFindDuplicate(lines)
println("First frequency reached twice: ", twice_f)