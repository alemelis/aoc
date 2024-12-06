# pt 1
G=readchomp("input.txt")
D=-131,1,131,-1
function solve(G,s=Set(),d=1)
    p=findfirst(==('^'),G)
    while 0<p<=length(G)&&G[p]!='\n'
        if G[p]=='#'
            p-=D[d]
            d=d%4+1
        else
            s=s∪p
            p+=D[d]
        end
    end
    s
end
solve(G)|>length|>println