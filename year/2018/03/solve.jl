# Day 3 - https://adventofcode.com/2018/day/3

using DelimitedFiles

function parseInput(filename::String)
	return readdlm(filename)
end

# part 1
"""
	parseClaims(lines::Array{Any,2})

Parse and convert lines from input list. Return an array.
"""
function parseClaims(lines::Array{Any,2})
	claims = [] # will contain parsed values

	for k = 1:size(lines)[1]
		# parsing
		idx = parse(Int64, lines[k,1][2:end])
		x, y = split(lines[k,3], ',')
		y = y[1:end-1]
		w, h = split(lines[k,4], 'x')
		x = parse(Int64, x)+1 # shift for zero index
		y = parse(Int64, y)+1
		w = parse(Int64, w)-1
		h = parse(Int64, h)-1
		area = (w+1)*(h+1) # for part 2
		push!(claims, [idx, x, y, w, h, area])
	end
	return claims
end

"""
	fillCarpet(claims::Array{Any,1})

Starting from a 1000x1000 zeros matrix this function fills
claim-by-claim the carpet.
"""
function fillCarpet(claims::Array{Any,1})
	carpet = zeros(Int64, (1000,1000))
	for k = 1:size(claims)[1]
		idx, x, y, w, h, area = claims[k]
		for j = x:x+w
			for i = y:y+h
				carpet[i,j] += 1
			end
		end
	end
	return carpet
end

"""
	countClaims(carpet::Array{Int64,2})

This function crosses the carpet inch-by-inch and keeps track
of how many claims are there. Returns the number of inches claimed
more than once.
"""
function countClaims(carpet::Array{Int64,2})
	c = 0
	for i = 1:1000
		for j = 1:1000
			if carpet[i,j] >= 2
				c += 1
			end
		end
	end
	return c
end

# part 2
"""
	findClaim(carpet::Array{Int64,2}, claims::Array{Any,1})

The carpet is explored claim-by-claim and the claim area is
compared with the carpet one.
"""
function findClaim(carpet::Array{Int64,2}, claims::Array{Any,1})

	for k = 1:size(claims)[1]
		idx, x, y, w, h, area = claims[k]
		if sum(carpet[y:y+h,x:x+w]) == area
			return idx
		end
	end
end

# 
lines = parseInput("day3.input")
claims = parseClaims(lines)
carpet = fillCarpet(claims)
p1_res = countClaims(carpet)
println("Sqi overlapping: ", p1_res)

p2_res = findClaim(carpet, claims)
println("Non overlapping claim: ", p2_res)