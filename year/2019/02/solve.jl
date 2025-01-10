line = collect(eval(Meta.parse(readchomp("input.txt"))))

function solve(line, noun, verb)
    line[2] = noun
    line[3] = verb

    i = 1
    while line[i] != 99
        op = line[i]
        a = line[line[i+1]+1]
        b = line[line[i+2]+1]
        dst = line[i+3]

        line[dst+1] = eval(Meta.parse("$a $(op == 1 ? "+" : "*") $b"))
        i += 4
    end
    line[1]
end

# *
solve(deepcopy(line), 12, 2) |> println

# **
function binsearch(line)
    target = 19690720
    a, b = 0, 99
    noun = 0
    while a<b
        noun = (a+b)÷2
        r = solve(deepcopy(line), noun, 0)
        if 0 < r + 99 - target < 99
            break
        elseif r < target
            a = noun+1
        elseif r > target + 99
            b = noun-1
        end
    end
    a, b = 0, 100
    verb = 0
    while a<b
        verb = (a+b)÷2
        r = solve(deepcopy(line), noun, verb)
        if r < target
            a = verb+1
        elseif r > target
            b = verb-1
        else
            break
        end
    end
    100 * noun + verb
end
binsearch(line) |> println
