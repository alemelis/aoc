function f(t,N,r,pt2)
 length(N)<1&&return t==r
 r>t&&return 2<1
 n=N[1]
 m=r<1 ? n : r*n
 f(t,N[2:end],r+n,pt2)||f(t,N[2:end],m,pt2)||(pt2&&f(t,N[2:end],parse(Int,"$r$n"),pt2))
end

L=readlines("input.txt")
L=split.(L,": ")
targets=parse.(Int,first.(L))
nums=split.(last.(L)).|>n->parse.(Int,n)
sum(targets.*f.(targets,nums,0,false))|>println
sum(targets.*f.(targets,nums,0,true))|>println
