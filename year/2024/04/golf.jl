using LinearAlgebra
!,/,~=join,sum,count
X=[r"XMAS",r"SAMX"]
R=readlines("input.txt")
l=140
L=!R
M=permutedims(reshape([L...],l,l))
print((s->(r->s~r)/R)/X+(s->(i->s~L[i:l:end])/(1:l))/X+(A->(s->(i->s~!diag(A,i))/(-l:l))/X)/[M,reverse(M,dims=2)]," ",(r->(k->(j->r~!(L[i*l+k:i*l+k+2] for i=j:j+2))/(0:l-3))/(1:l-2))/[r"M.S.A.M.S",r"M.M.A.S.S",r"S.S.A.M.M",r"S.M.A.S.M"])