CI=CartesianIndex

# lines = readlines("input.txt")
lines = readlines("example.txt")

garden = stack([[line...] for line in lines])
width, height = size(garden)

N = CI(0, -1)
E = CI(1,  0)
S = CI(0,  1)
W = CI(-1, 0)

oob(p) = ~(0<p[1]<=width&&0<p[2]<=height)

function countedges(fence)
    edges = Dict()
    for f=fence
        shift = f[2]-f[1]
        shift∉keys(edges) && (edges[shift]=[])
        push!(edges[shift], f)
    end


    num_edges = 0
    for shift=keys(edges)
        sides = sort(first.(edges[shift]), by=c->(c[1], c[2]))
        num_edges += 1
        length(sides)==1&&continue
        p = sides[1]
        println(p)
        seen = Set()
        push!(seen, p)
        for s=sides[2:end]
            if s∈seen
                num_edges += 1
                push!(seen,s)
                p = s
                continue
            end
            println(s)
            push!(seen,s)

            d = p-s
            if abs(d.I[1]+d.I[2]) > 1
                num_edges += 1
                println("break")
            end
            p = s
        end
            



        # if shift[1]==0
        #     num_edges += length(Set(s[1].I[2] for s=sides))
        #     println(shift, " ", length(Set(s[1].I[2] for s=sides)))

        # else #if shift[2]==0
        #     num_edges += length(Set(s[1].I[1] for s=sides))
        #     println(shift, " ", length(Set(s[1].I[1] for s=sides)))
        #     println.(sides)
        # end
    end
    num_edges
end

function bfs(garden, s, visited)
    queue = [s]
    plant = garden[s]
    area = 0
    perimeter = 0
    fence = Set()
    while ~isempty(queue)
        p = pop!(queue)
        p∉visited&&(area += 1)

        push!(visited, p)
        for d in (N, E, S, W)
            if oob(p+d) || garden[p+d] != plant
                (p, p+d) ∉ fence && (perimeter += 1)
                push!(fence, (p, p+d))
            else
                p+d ∉ visited && push!(queue, p+d)
            end
        end
    end
    ce = countedges(fence)
    println(plant, " ", area, " ", perimeter, " ", ce)
    area * perimeter, area * ce
end

function solve(garden)
    visited = Set()
    total_price1 = 0
    total_price2 = 0
    for i=1:height,j=1:width
        p=CI(i,j)
        p∈visited&&continue
        price = bfs(garden, p, visited)
        total_price1 += price[1]
        total_price2 += price[2]
        println(p, " ", garden[p], " ", price)
    end
    total_price1, total_price2
end
solve(garden)|>println