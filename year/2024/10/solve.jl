using DataStructures

CI=CartesianIndex

lines = readlines("input.txt")

topo = stack([[line...] for line in lines])
topo[topo.=='.'] .= '1'
topo = parse.(Int, topo)
width, height = size(topo)
top_left = CI(0,0)
bottom_right = CI(width, height)

N = CI(0, -1)
E = CI(1,  0)
S = CI(0,  1)
W = CI(-1, 0)

oob(p) = ~(0<p[1]<=width&&0<p[2]<=height)

function hike(topo, s)
    queue = Queue{CartesianIndex}()
    enqueue!(queue, s)
    found = Set()
    score = 0
    ratings = Dict()
    while ~isempty(queue)
        p = dequeue!(queue)
        if topo[p] == 9
            p∉found && (push!(found, p); score += 1)
            ratings[(s, p)] = get(ratings, (s, p), 0) + 1
        end
        for d in (N, E, S, W)
            (oob(p+d) || topo[p+d] != topo[p] + 1) && continue
            enqueue!(queue, p+d)
        end
    end
    (score, sum(v->v[2],ratings))
end

# same with stack?
function hikes(topo, s)
    queue = []
    push!(queue, s)
    found = Set()
    score = 0
    ratings = Dict()
    while ~isempty(queue)
        p = popfirst!(queue)
        if topo[p] == 9
            p∉found && (push!(found, p); score += 1)
            ratings[(s, p)] = get(ratings, (s, p), 0) + 1
        end
        for d in (N, E, S, W)
            (oob(p+d) || topo[p+d] != topo[p] + 1) && continue
            push!(queue, p+d)
        end
    end
    (score, sum(v->v[2],ratings))
end

res = findall(==(0), topo).|>s->hike(topo, s)
sum(first.(res))|>println
sum(last.(res))|>println