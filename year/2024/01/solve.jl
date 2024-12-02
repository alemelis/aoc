using DelimitedFiles
lines = readdlm("input.txt", Int)
lx, rx = sort.(eachcol(lines))

# *
sum(abs, lx-rx) |> println

# **
sum(n->count(==(n), rx)n, lx) |> println
