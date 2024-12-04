using LinearAlgebra

rows = readlines("input.txt")
line = join(rows)

# *
l = length(rows[1])
rs = [r"XMAS", r"SAMX"]
tot = sum(s->sum(r->count(s, r), rows),rs) # horizontal
tot += sum(s->sum(i->count(s, line[i:l:end]), 1:l),rs) # vertical

# diagonals
M = permutedims(reshape([line...], l, l))
tot+sum(A->sum(s->sum(i->count(s, join(diag(A, i))), -l:l), rs), [M, reverse(M, dims=2)])|>println

# **
sum(r->
 sum(k->
  sum(j->
   count(r, join(line[i*l+k:i*l+k+2] for i=j:j+2)),
  0:l-3),
 1:l-2),
[r"M.S.A.M.S", r"M.M.A.S.S", r"S.S.A.M.M", r"S.M.A.S.M"])|>println