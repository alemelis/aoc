function findPowerLevel(x::Int64, y::Int64, serial_no::Int64)
	rack_id = x + 10
	pwr_lvl = y*rack_id + serial_no
	pwr_lvl *= rack_id
	pwr_lvl /= 100
	pwr_lvl = parse(Int, string(Int(floor(pwr_lvl)))[end])
	return pwr_lvl - 5
end

function fillGrid(N::Int64, serial_no::Int64)
	grid = zeros(Int64, N, N)
	for x = 1:N
		for y = 1:N
			grid[y,x] = findPowerLevel(x, y, serial_no)
		end
	end
	return grid
end

function convolve(grid::Array{Int64,2}, kernel_size::Int64)
	max_total_power = 0
	top_left = (0,0)
	for x = 1:size(grid)[1]-kernel_size
		for y = 1:size(grid)[1]-kernel_size
			total_power = 0
			for i = 0:kernel_size-1
				for j = 0:kernel_size-1
					total_power += grid[y+i,x+j]
				end
			end
			if total_power > max_total_power
				top_left = (x,y)
				max_total_power = total_power
			end
		end
	end
	return top_left, max_total_power
end

function findMaxPowerIdx(total_powers::Array{Int64,1})
	max_power = 0
	max_i = 0
	for i = 1:length(total_powers)
		if total_powers[i] > max_power
			max_i = i
			max_power = total_powers[i]
		end
	end
	return max_i
end

function searchMaxKernelSize(grid::Array{Int64,2})
	total_powers = zeros(Int64,0)
	coordinates = []
	for kernel_size = 2:size(grid)[1]-1 # 1 element padding
		top_left, total_power = convolve(grid, kernel_size)
		if total_power > 0
			push!(total_powers, total_power)
			push!(coordinates, top_left)
		else
			max_total_power_idx = findMaxPowerIdx(total_powers)
			max_top_left = coordinates[max_total_power_idx]
			max_kernel = max_total_power_idx+1
			return max_top_left, max_kernel
		end
	end

end

# part 1
serial_no = 7347
N = 300
kernel_size = 3
grid = fillGrid(N, serial_no)
top_left, max_total_power = convolve(grid, kernel_size)
println("Top-left coordinate of 3x3 fuel cell: ", top_left)

# part 2
max_top_left, max_kernel = searchMaxKernelSize(grid)
println("Largest power cell top-left coordinate: ", max_top_left)
println("Largest power cell kernel size: ", max_kernel)