input = readlines("input.txt")
lines = input.|>l->parse.(Int, split(l))

# *
check(l) = (issorted(l)||issorted(l, rev=true))&&all(0 .<extrema(abs, diff(l)).<4)
sum(check, lines) |> println

# **
check2(l) = check(l) || any(1:length(l).|>i->check([l[j] for j=1:length(l) if j!=i]))
sum(check2, lines) |> println
