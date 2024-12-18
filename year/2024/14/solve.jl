lines = readlines("input.txt")
robots = lines.|>l->match.(r"p\=(\d+,\d+)\sv\=(-?\d+,-?\d+)", l).|>m->eval.(Meta.parse.([m[1],m[2]]))

function walk(robot, steps)
    w, h = 101, 103
    p, s = robot
    x, y = p.+1
    u, v = s
    x += u*steps
    y += v*steps

    x %= w
    y %= h

    x < 1 && (x += w)
    y < 1 && (y += h)

    (x, y)
end

function countquadrants(robots)
    p = 1
    w, h = 101, 103

    for (a,b,c,d)=(
        (0, w÷2+1, 0, h÷2+1),
        (w÷2+1, w+1, 0, h÷2+1),
        (0, w÷2+1, h÷2+1, h+1),
        (w÷2+1, w+1, h÷2+1, h+1)
        )
        s = 0
        for (x,y)=robots
            s+=a<x<b&&c<y<d
        end
        p *= s
    end
    p
end

new_robots = walk.(robots, 100)
countquadrants(new_robots) |> println # *
findmin([countquadrants(walk.(robots, i)) for i=1:20000])[2] |> println # **