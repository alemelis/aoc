line = parse.(Int, split(readchomp("input.txt")))

function parserocks(line)
    rocks = Dict{Int,Int}()
    for rock in line
        rocks[rock] = get(rocks, rock, 0) + 1
    end
    rocks
end

rocks = parserocks(line)

function blink(rocks::Dict{Int,Int})
    new_rocks = Dict{Int, Int}()
    for rock in keys(rocks)
        num_rocks = rocks[rock]
        if rock == 0
            new_rocks[1] = get(new_rocks, 1, 0) + num_rocks
        elseif ndigits(rock)%2<1
            str = "$rock"
            lx = parse.(Int, str[1:end÷2])
            rx = parse.(Int, str[end÷2+1:end])
            new_rocks[lx] = get(new_rocks, lx, 0) + num_rocks
            new_rocks[rx] = get(new_rocks, rx, 0) + num_rocks
        else
            new_rocks[rock*2024] = get(new_rocks, rock*2024, 0) + num_rocks
        end
    end
    new_rocks
end

function solve(rocks)
    for _=1:25
        rocks=blink(rocks)
    end
    sum(values(rocks))|>println


    for i=1:50
        rocks=blink(rocks)
    end
    sum(values(rocks))|>println
end
solve(rocks)

