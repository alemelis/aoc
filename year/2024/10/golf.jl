using DataStructures;C=CartesianIndex;
O(p)=~(0<p[1]<=W&&0<p[2]<=H);T=parse.(
Int,stack([[l...] for l=readlines(#...
"input.txt")]));W,H=size(T);A(T,s)=(Q=
Queue{C}();enqueue!(Q,s);(F,S,R)=(Set(
),0,Dict());while~isempty(Q);p=#......
dequeue!(Q);T[p] == 9&&(p∉F && (push!(
F,p);S+=1);(R[(s,p)]=get(R,(s,p),0)+1)
);for d=(C(0,-1),C(1,0),C(0,1),C(-1,0)
);(O(p+d)||T[p+d]≠T[p]+1)&&continue;#.
enqueue!(Q,p+d)end;end;(S,sum(last,R))
);[first,last].|>f->sum(f.(findall(==(
0),T).|>s->A(T,s)))|>println#.........

# stack
C=CartesianIndex;O(p)=~(0<p[1]<=W&&0<p[2]<=H);T=parse.(Int,stack([[l...] for l=readlines()]));W,H=size(T);A(T,s)=(Q=[];push!(Q,s);(F,S,R)=(Set(),0,Dict());while~isempty(Q);p=popfirst!(Q);T[p]>8&&(p∉F&&(push!(F,p);S+=1);(R[(s,p)]=get(R,(s,p),0)+1));for d=(C(0,-1),C(1,0),C(0,1),C(-1,0));(O(p+d)||T[p+d]≠T[p]+1)&&continue;push!(Q,p+d)end;end;(S,sum(last,R)));[first,last].|>f->sum(f.(findall(==(0),T).|>s->A(T,s)))|>println
