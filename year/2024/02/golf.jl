L=readlines(stdin).|>l->parse.(Int,split(l))
~,!,s=sum,length,issorted
C(l)=(s(l)||s(l,rev=1<2))*abs.(diff(l))⊆1:3
print(C~L," ",(l->C(l)||any(1:!l.|>i->C([l[j] for j=1:!l if j!=i])))~L)