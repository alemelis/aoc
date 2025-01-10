line = collect(eval(Meta.parse(readchomp("input.txt"))))

#=
before running the program
replace position 1 with the value 12
and replace position 2 with the value 2
=#
line[2] = 12
line[3] = 2

function solve(line)
    i = 1
    while line[i] != 99
        op = line[i]
        a = line[line[i+1]+1]
        b = line[line[i+2]+1]
        dst = line[i+3]

        line[dst+1] = eval(Meta.parse("$a $(op == 1 ? "+" : "*") $b"))
        i += 4
    end
    println(line[1])
end
solve(line)
