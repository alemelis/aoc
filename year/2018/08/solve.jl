using DelimitedFiles

function readInput(filename)
	return vec(readdlm(filename, ' ', Int64))
end

# This works for the example (part 1), not for the real input...
function addMetadataPop(numbers)
	n = deepcopy(numbers)
	s = 0
	while length(n) != 0
		no_children = n[1]
		no_metadata = n[2]
		deleteat!(n, [1,2])
		
		if no_children == 0
			for i = 1:no_metadata
				s += n[1]
				deleteat!(n, 1)
				if length(n) == 0
					return s
				end
			end
		else
			for i = 1:no_metadata
				s += pop!(n)
				if length(n) == 0
					return s
				end
			end
		end
	end
	return s
end

# recursive working solution
function climb(numbers)
	children = numbers[1]
	metadata = numbers[2]
	data = numbers[3:end]
	val = 0
	vals = []

	s = 0
	for j = 1:children
		res = climb(data)
		s += res[1]
		data = res[2]
		append!(vals, res[3])
	end

	for j = 1:metadata
		val += data[j]
	end
	s += val

	if children == 0
		return (s, data[metadata+1:end], val)
	else
		val = 0
		for j = 1:metadata
			if data[j] <= length(vals)
				val += vals[data[j]]
			end
		end 
	end	

	return (s, data[metadata+1:end], val)
end

numbers = readInput("day8.input")
solutions = climb(numbers)
println("Sum of all metadata entries: ", solutions[1])
println("Value of the root node: ", solutions[3])
