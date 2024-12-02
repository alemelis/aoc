 using DelimitedFiles

function readInput(filename::String)
	return readdlm(filename)[1]
end

function collapseUnits(a, b)
	if (a - 32 == b) || (a + 32 == b)
		return true
	else
		return false
	end
end

function fullyReact(polymer)
	i = 1
	while i < length(polymer)
		if collapseUnits(polymer[i], polymer[i+1])
			if i == 1
				polymer = polymer[3:end]
			else
				polymer = polymer[1:i-1]*polymer[i+2:end]
			end
			if i < 4
				i = 1
			else
				i -= 3
			end
		else
			i += 1
		end
	end
	return length(polymer)
end

function removeX(polymer, x)
	i = 1
	while i <= length(polymer)
		if polymer[i] == x || polymer[i] == x - 32
			if i == 1
				polymer = polymer[2:end]
			else
				polymer = polymer[1:i-1]*polymer[i+1:end]
			end
			if i < 2
				i = 1
			else
				i -= 1
			end
		else
			i += 1
		end
	end
	return polymer
end

# First, slow version
# part 1
polymer = readInput("day5.input")
res1 = fullyReact(polymer)
println("Units after fully react: ", res1)

# part 2
res2 = []
for i = 0:25
	x = 'a' + i
	trimmed_polymer = removeX(polymer, x)
	r2 = fullyReact(trimmed_polymer)
	push!(res2, r2)
end
println("Shortest polymer: ", minimum(res2), " units")


# Second, fast version (thanks Julien!)
function fullyReactSplit(polymer)
	polymer_len = length(polymer)
	while true
		for i = 0:25
			x = 'a' + i
			polymer = join(split(polymer, string(x)*string(x-32)))
			polymer = join(split(polymer, string(x-32)*string(x)))
		end
		if length(polymer) == polymer_len
			return polymer_len
		else
			polymer_len = length(polymer)
		end
	end
end

function splitXjoin(polymer, x)
	polymer = join(split(polymer, x))
	return join(split(polymer, x - 32))
end

# part 1
res1_fast = fullyReactSplit(polymer)
println("Units after fully react: ", res1_fast)

# part 2
res2_fast = []
for i = 0:25
	x = 'a' + i
	trimmed_polymer = splitXjoin(polymer, x)
	r2 = fullyReactSplit(trimmed_polymer)
	push!(res2_fast, r2)
end
println("Shortest polymer: ", minimum(res2_fast), " units")