CI=CartesianIndex

lines = readlines("input.txt")

city = stack([[line...] for line in lines])
width, height = size(city)
top_left = CI(0,0)
bottom_right = CI(width, height)

nodes = findall(!=('.'), city)
frequencies = Dict()
for node in nodes
	frequencies[city[node]] = push!(get(frequencies, city[node], []), node)
end

inb(p) = 0<p.I[1]<=bottom_right.I[1] && 0<p.I[2]<=bottom_right.I[2]

function solve(frequencies, pt2)
	antinodes = Set()
	for f in keys(frequencies)
		freq_nodes = frequencies[f]
		pt2 && push!(antinodes, freq_nodes...)
		for a=freq_nodes, b=freq_nodes
			a == b && continue
			distance = b - a
			mul = 1
			pt2 && push!(antinodes, a)
			pt2 && push!(antinodes, b)
			while true
				ad = a + mul*distance; ad!=b && inb(ad) && push!(antinodes, ad)
				an = a - mul*distance; an!=b && inb(an) && push!(antinodes, an)
				bd = b + mul*distance; bd!=a && inb(bd) && push!(antinodes, bd)
				bn = b - mul*distance; bn!=a && inb(bn) && push!(antinodes, bn)
				(~pt2 || (~inb(ad)&&~inb(an)&&~inb(bd)&&~inb(bn))) && break
				mul+=1
			end
		end
	end
	length(antinodes)
end

println.(solve(frequencies, b) for b=[false, true])
