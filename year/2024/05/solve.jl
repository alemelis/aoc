rules, updates = split.(split(readchomp("input.txt"),"\n\n"))

rules = split.(rules, "|").|>r->parse.(Int, r)
lrules = first.(rules)
rrules = last.(rules)

updates = split.(updates, ",").|>u->parse.(Int, u)

# like defaultdict
order = Dict()
for (i, rl) in enumerate(lrules)
    push!(get!(order, rl, Set(rrules[i])), rrules[i])
end

compare(a, b) = b ∈ order[a]

# *
# sum(u[end÷2+1] for u=updates if issorted(u, lt=compare))|>println

# **
# sum((sort!(u, lt=compare);u[end÷2+1]) for u = updates if ~issorted(u, lt=compare))|>println

# !!! found on zulip that my compare can be written as this lt and avoid defaultdict stuff

rules, updates = split.(split(readchomp("input.txt"),"\n\n"))
updates = split.(updates, ",").|>u->parse.(Int, u)
lt = (a, b) -> "$a|$b" ∈ rules

# *
sum(u[end÷2+1] for u=updates if issorted(u, lt=lt))|>println

# **
sum(sort(u, lt=lt)[end÷2+1] for u=updates if ~issorted(u, lt=lt))|>println