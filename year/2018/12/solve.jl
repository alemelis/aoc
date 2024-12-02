function readInput(filename)
	f = open(filename)
	lines = readlines(f)
	close(f)

	s0 = split(lines[1], ' ')[3]
	rules = Set()
	for line in lines[3:end]
		rule_line = split(line, ' ')
		rule = rule_line[1]
		rule_result = rule_line[3]
		if rule_result == "#"
			push!(rules, rule)
		end
	end

	return s0, rules
end

function trimEnds(s1, zero_idx)
	while s1[1:5] == "....."
		s1 = s1[6:end]
		zero_idx -= 5
	end
	if s1[end-4:end] == "....."
		s1 = s1[1:end-5]
	end
	return s1, zero_idx
end

function evolve(s0, rules, zero_idx=1)
	s0_extended = "."^5*s0*"."^5
	s1 = deepcopy(s0_extended)
	zero_idx += 5
	for i = 1:length(s0_extended)-5
		if s0_extended[i:i+4] in rules
			s1 = s1[1:i+1]*"#"*s1[i+3:end]
		else
			if s0_extended[i+2] == '#'
				s1 = s1[1:i+1]*"."*s1[i+3:end]
			end
		end
	end
	return trimEnds(s1, zero_idx)
end

function countPots(s1, zero_idx)
	j = -zero_idx+1
	c = 0
	for i = 1:length(s1)
		if s1[i] == '#'
			c += j
		end
		j += 1
	end
	return c
end

function stepTime(s0, rules, epochs)
	zero_idx = 1
	old_pots = 0
	for i = 1:epochs
		s0, zero_idx = evolve(s0, rules, zero_idx)
	end
	return s0, zero_idx
end

# slightly different method for the second part
function trimEnds(s1)
	while true
		if s1[1] == '.'
			s1 = s1[2:end]
		else
			break
		end
	end
	while true
		if s1[end] == '.'
			s1 = s1[1:end-1]
		else
			break
		end
	end
	return s1
end

function computeBillionPots(s0, rules, giga_epochs)
	epochs = 0
	zero_idx = 1
	s0_old = s0
	s0_trim = s0
	pots_old = 0
	while true
		epochs += 1
		s0, zero_idx = evolve(s0, rules, zero_idx)
		pots = countPots(s0, zero_idx)
		s0_trim = trimEnds(s0)
		if s0_trim == s0_old
			increment = pots-pots_old
			return pots+(giga_epochs-epochs)*increment
		else
			s0_old = s0_trim
			pots_old = pots
		end
	end
end


# part 1
epochs = 20
s0, rules = readInput("day12.input")
s1, zero_idx = stepTime(s0, rules, epochs)
pots = countPots(s1, zero_idx)
println("Total number of plants after 20 generations: $pots")

# part 2
giga_epochs = 50000000000
giga_pots = computeBillionPots(s0, rules, giga_epochs)
println("Total number of plants after $giga_epochs generations: $giga_pots")