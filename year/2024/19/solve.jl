patterns, designs = split(readchomp("input.txt"), "\n\n")
patterns = split(patterns, ", ")
designs = split.(designs)

# *
re = Regex("^("*join(patterns, "|")*")+\$")
count(m->~isnothing(m), match.(re, designs)) |> println