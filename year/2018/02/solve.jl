# Day 2 - https://adventofcode.com/2018/day/2

# this is part of the Julia standard library
using DelimitedFiles

function parseInput(filename::String)
	return readdlm(filename)
end

# part 1

"""
	countLettersInLine(line::SubString{String})

This is a kernel function looking for letters occurring
two or three times. We do not care to keep track of which
letter is occurring more than once, we are simply happy to
know that there is at least one.
"""
function countLettersInLine(line::SubString{String})
	letters_counted = []
	twice = 0
	trice = 0
	for i = 1:length(line)-1
		if line[i] in letters_counted
			continue
		else
			c = 1
			append!(letters_counted, line[i])
		end
		for j = i+1:length(line)
			if line[i] == line[j]
				c += 1
			end
		end
		if c == 2 
			twice = 1
		elseif c == 3
			trice = 1
		end
	end
	return (twice, trice)
end

"""
	countInAllLines(lines::Array{SubString{String}})

Pass the kernel over all the lines in the input file.
"""
function countInAllLines(lines::Array{SubString{String}})
	twice = 0
	trice = 0
	for i = 1:length(lines)
		tt = countLettersInLine(lines[i])
		twice += tt[1]
		trice += tt[2]
	end
	return (twice, trice)
end

"""
	computeChecksum(tt::Tuple{Int64,Int64})
"""
function computeChecksum(tt::Tuple{Int64,Int64})
	return tt[1]*tt[2]
end

# part 2
"""
	findMatchingLines(lines::Array{SubString{String}})

Check line-by-line if two strings are identical (except for one letter).
Return the two semi-matching lines.
"""
function findMatchingLines(lines::Array{SubString{String}})
	len_line = length(lines[1])
	wrong_idx = -1
	for i = 1:length(lines)-1
		for j = i+1:length(lines)
			c = 0
			for k = 1:len_line
				if lines[i][k] == lines[j][k]
					c += 1
				else
					wrong_idx = k
				end
			end
			if c == len_line-1
				return (lines[i], lines[j], wrong_idx)
			end
		end
	end
end

"""
	getCommonletters(ijk::Tuple{SubString{String},SubString{String},Int64})

Exctract the only non matching letter from the two strings and return the other
letters.
"""
function getCommonletters(ijk::Tuple{SubString{String},SubString{String},Int64})
	new_string = []
	k = ijk[3]
	for i = 1:length(ijk[1])
		if i == k
			continue
		else
			append!(new_string, ijk[1][i])
		end
	end
	return join(new_string)
end

# Run part 1
all_lines = parseInput("day2.input")
checksum = computeChecksum(countInAllLines(alllines))
println("Checksum: ", checksum)

# Run part 2
common_str = getCommonletters(findMatchingLines(all_lines))
println("Matching string: ", common_str)

