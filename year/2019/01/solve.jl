masses = parse.(Int, readlines("input.txt"))

# *
fuel(mass) = mass÷3 - 2
sum(fuel, masses) |> println

# **
fuel4fuel(mass, f=0) = (mass=fuel(mass)) > 0 ? fuel4fuel(mass, f+mass) : f
sum(fuel4fuel, masses) |> println
