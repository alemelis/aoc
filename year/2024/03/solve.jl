input = join(readlines("input.txt"))
!m=parse(Int,m)

# *
sum(eachmatch(r"mul\(([0-9]+),([0-9]+)\)",input).|>m->!m[1]*!m[2])|>println

# **
~=isnothing
function solve(i,s=0,mul=1)
  for m=eachmatch(r"(do\(\))|(don\'t\(\))|mul\(([0-9]+),([0-9]+)\)",i)
    if ~m[1]&&~m[2]
      s += mul*(!m[3]*!m[4])
    else
      mul = ~m[1] ? 0 : 1
    end
  end
  s
end
solve(input)|>println