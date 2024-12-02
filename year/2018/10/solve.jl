using DelimitedFiles
using Plots

function readPts(filename)
	f = open(filename)
	lines = readlines(f)
	close(f)

	data = zeros(Int64, length(lines), 4)
	for i = 1:length(lines)
		line = lines[i]
		line = split(line, ',')
		x = parse(Int, split(line[1], '<')[2])
		yvx = split(line[2], '>')
		y = parse(Int, yvx[1])
		vx = parse(Int, split(yvx[2], '<')[2])
		vy = parse(Int, line[3][1:end-1])
		data[i,1] = x
		data[i,2] = y
		data[i,3] = vx
		data[i,4] = vy
		println(x, " ", y, " ", vx, " ", vy)
	end
	return data
end


function drawPoints(pts, i)
	# mirror y coordinates and plot
	scatter(pts[:,1], pts[:,2].-2*(pts[:,2]), title=string(i))
end


function updatePts(pts)
	for i = 1:size(pts)[1]
		pts[i,1] += pts[i,3]
		pts[i,2] += pts[i,4]
	end
	return pts
end


function fireworks(pts)
	i = 0
	while true
		display(drawPoints(pts, i))
		sleep(0.001)
		pts = updatePts(pts)
		i+=1
	end
end

# part 1 and 2
pts = readPts("day10.input")
fireworks(pts)