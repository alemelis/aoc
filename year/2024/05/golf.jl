S=split;R,U=S.(S(readchomp("input.txt"),"\n\n"));U=S.(U,",").|>u->parse.(Int,u)
lt=(a,b)->"$a|$b"∈R;!u=issorted(u,lt=lt);print(sum(u[end÷2+1] for u=U if !u)," "
,sum((sort!(u, lt=lt);u[end÷2+1]) for u=U if~!u))