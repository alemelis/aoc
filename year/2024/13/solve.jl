lines = split.(split(readchomp("input.txt"), "\n\n"),"\n")
machines = lines.|>m->match.(r".+X[=|+](\d+),\sY[=|+](\d+)", m)

function play(machine, offset)
	a, b, p = machine
	ax, ay = parse.(Int, a)
	bx, by = parse.(Int, b)
	px, py = parse.(Int, p) .+ offset

	M = [ax bx; ay by]
	Y = [px; py]
	X = round.(Int, M\Y)

	M*X==Y ? X[1]*3 + X[2] : 0
end

(0, 10000000000000).|>offset->sum(play.(machines, offset)).|>println