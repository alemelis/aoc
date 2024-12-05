rules, updates = split.(split(readchomp("input.txt"),"\n\n"))
updates = split.(updates, ",").|>u->parse.(Int, u)
lt = (a, b) -> "$a|$b" ∈ rules

# *
sum(u[end÷2+1] for u=updates if issorted(u, lt=lt))|>println

# **
sum(sort(u, lt=lt)[end÷2+1] for u=updates if ~issorted(u, lt=lt))|>println