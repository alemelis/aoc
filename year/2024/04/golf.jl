using LinearAlgebra;!,/,~,X,l=join,sum,count,[r"XMAS",r"SAMX"],140
R=readlines("input.txt");L=!R;M=permutedims(reshape([L...],l,l))
println.([(s->(r->s~r)/R)/X+(s->(i->s~L[i:l:end])/(1:l))/X+(A->(s->(i->s~!diag(A
,i))/(-l:l))/X)/[M,reverse(M,dims=2)];(r->(k->(j->r~!(L[i*l+k:i*l+k+2] for i=j:j
+2))/(0:l-3))/(1:l-2))/[r"M.S.A.M.S",r"M.M.A.S.S",r"S.S.A.M.M",r"S.M.A.S.M"]])