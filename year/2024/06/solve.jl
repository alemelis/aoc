lines = readlines("input.txt")

maze = stack([[line...] for line in lines])
start_row = findfirst(line->occursin('^', line), lines)
start_col = findfirst(==('^'), lines[start_row])

CI = CartesianIndex
start = CI(start_col, start_row)

N = CI(0, -1)
E = CI(1,  0)
S = CI(0,  1)
W = CI(-1, 0)
rotate = Dict(zip([N,E,S,W],[E,S,W,N]))
draw = Dict(zip([N, S, W, E],["^v<>"...]))

oob(p) = ~(0<p[1]<=size(maze)[1]&&0<p[2]<=size(maze)[2])

function solve(maze, pos, direction; f=:pt1)
    seen = Set([pos])
    start = deepcopy(pos)
    blocks = 0
    while true
        step = pos + direction
        oob(step) && return f==:pt1 ? length(seen) : f==:pt2 ? blocks : false

        maze[step] == '#' && (direction = rotate[direction];continue)
        if f==:pt1
            pos = step
            push!(seen, pos)
        elseif f==:pt2
            if step != start && step∉seen 
                maze[step] = '#'
                blocks += solve(maze, pos, direction; f=:check)
                push!(seen, step)
                maze[step] = '.'
                maze[maze.!='#'].='.'
            end
            pos = step
        elseif f==:check
            maze[step] == draw[direction] && return true
            maze[step] = draw[direction]
            pos = step
        end
    end
end

solve(maze, deepcopy(start), N; f=:pt1) |> println
solve(maze, start, N; f=:pt2) |> println