using DelimitedFiles

function readInput(filename)
	lines = readdlm(filename)

	edges = zeros(Int64, size(lines)[1], 2)
	for i = 1:size(lines)[1]
		edges[i,1] = Int(lines[i,2][1]) - 64
		edges[i,2] = Int(lines[i,8][1]) - 64
	end
	return edges
end

mutable struct Node
	parents :: Set
	label :: String
	build_time :: Int64
end

mutable struct Worker
	busy :: Bool
	assigned_step :: Node
end

function allocNodes(input_edges)
	nodes = Dict()
	for i in Set(input_edges)
		label = string(Char(i+64))
		parents = []
		for j = 1:size(input_edges)[1]
			if input_edges[j,2] == i
				push!(parents, input_edges[j,1])
			end
		end
		nodes[string(i)] = Node(Set(parents), label, i)
	end

	return nodes
end

function buildSleigh(nodes)
	availables = Set()
	instructions = ""
	while length(instructions) != length(nodes)
		for n in keys(nodes)
			if occursin(nodes[n].label, instructions)
				continue
			end

			if isempty(nodes[n].parents)
				push!(availables, nodes[n].label)
			end
		end

		if isempty(availables) == false
			instructions *= minimum(availables)
			delete!(availables, minimum(availables))
		end

		for n in keys(nodes)
			if occursin(nodes[n].label, instructions)
				continue
			else
				for k in nodes[n].parents
					if occursin(string(Char(k+64)), instructions)
						delete!(nodes[n].parents, k)
					end
				end
			end
		end
	end
	return instructions
end

function allocNodes60(input_edges)
	nodes = Dict()
	for i in Set(input_edges)
		label = string(Char(i+64))
		parents = []
		for j = 1:size(input_edges)[1]
			if input_edges[j,2] == i
				push!(parents, input_edges[j,1])
			end
		end
		nodes[string(i)] = Node(Set(parents), label, i+60)
	end

	return nodes
end

function buildSleighParallel(nodes, no_workers)
	workers = []
	for i = 1:no_workers
		push!(workers, Worker(false, Node(Set(), "", 0)))
	end

	availables = Set()
	availables_d = Dict()
	available_keys = []
	in_construction = Set()
	instructions = ""
	t = -1
	while length(instructions) != length(nodes)
		for n in keys(nodes)
			if occursin(nodes[n].label, instructions)
				continue
			end

			if isempty(nodes[n].parents)
				if (nodes[n].label in in_construction) == false
					availables_d[nodes[n].label] = nodes[n]
					kk = []
					for k in keys(availables_d)
						push!(kk, k)
					end
					available_keys = sort(kk)
					
				end
			end
		end

		for i = 1:no_workers
			if workers[i].busy
				if workers[i].assigned_step.build_time == 0
					instructions *= workers[i].assigned_step.label
					workers[i] = Worker(false, Node(Set(), "", 0))
				else
					workers[i].assigned_step.build_time -= 1
				end
			end
		end

		for n in keys(nodes)
			if occursin(nodes[n].label, instructions)
				continue
			else
				for k in nodes[n].parents
					if occursin(string(Char(k+64)), instructions)
						delete!(nodes[n].parents, k)
					end
				end
			end
		end

		# you need to repeat the above in case a worker finishes a step and
		# you want to allocate one more...could be better writing a function
		# to allocate job

		for n in keys(nodes)
			if occursin(nodes[n].label, instructions)
				continue
			end

			if isempty(nodes[n].parents)
				if (nodes[n].label in in_construction) == false
					availables_d[nodes[n].label] = nodes[n]
					kk = []
					for k in keys(availables_d)
						push!(kk, k)
					end
					available_keys = sort(kk)
					
				end
			end
		end

		for i = 1:no_workers
			if (workers[i].busy == false)
				if isempty(available_keys) == false
					available_key = popfirst!(available_keys)
					workers[i].assigned_step = availables_d[available_key]
					workers[i].assigned_step.build_time -= 1
					workers[i].busy = true
					delete!(availables_d, available_key)
					push!(in_construction, available_key)
				end
			end
		end

		for n in keys(nodes)
			if occursin(nodes[n].label, instructions)
				continue
			else
				for k in nodes[n].parents
					if occursin(string(Char(k+64)), instructions)
						delete!(nodes[n].parents, k)
					end
				end
			end
		end
		t += 1
	end
	return t
end

# part 1
input_edges = readInput("day7.input")
nodes = allocNodes(input_edges)
instructions = buildSleigh(nodes)
println("Instruction steps order: ", instructions)

# part 2
nodes60 = allocNodes60(input_edges)
elapsed_time = buildSleighParallel(nodes60, 5)
println("Elapsed time: ", elapsed_time)