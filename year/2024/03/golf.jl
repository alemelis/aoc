L=join(readlines("input.txt"))
!m=parse(Int,m)
e,~=eachmatch,isnothing
S(i,s=0,M=1)=(e(r"(do\(\))|(don\'t\(\))|mul\(([0-9]+),([0-9]+)\)",i).|>m->~m[1]&&~m[2] ? (s+=(!m[3]*!m[4])M) : (M=[1,0][1+~m[1]]);s)
print(sum(e(r"mul\(([0-9]+),([0-9]+)\)",L).|>m->!m[1]*!m[2])," ",S(L))