using DelimitedFiles
input = readlines("input.txt")
lines = input.|>l->parse.(Int, split(l))

# *
s = issorted
check(l) = (s(l)||s(l,rev=true))&&all(0 .<extrema(abs, diff(l)).<4)
sum(check, lines) |> println

# **
! = length
check2(l) = check(l) ? 1<2 : any(1:!l.|>i->check([l[j] for j=1:!l if j!=i]))
sum(check2, lines) |> println
