p,d=split(readchomp(stdin),"\n\n")
count(m->~isnothing(m),match.(Regex("^("*join(split(p,", "),"|")*")+\$"),split.(d)))|>println
println(0)