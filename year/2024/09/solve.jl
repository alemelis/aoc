line = readchomp("input.txt")
nums = [line...]
function solve1(nums)
    disk_map = []
    id = 0
    for (i,n)=enumerate(nums)
        if i%2>0
            push!(disk_map, repeat([id],parse.(Int, n))...)
            id += 1
        else
            push!(disk_map, repeat([-1], parse.(Int, n))...)
        end
    end

    nempty=count(==(-1),disk_map)
    disk_map[disk_map.==-1] .= reverse(disk_map[disk_map.!=-1])[1:nempty]
    disk_map = disk_map[1:end-nempty]

    sum([0:length(disk_map)-1;].*disk_map)|>println
end
solve1(nums)

function solve2(nums)
    disk_map = []
    id = 0
    for (i,n)=enumerate(nums)
        if i%2>0
            push!(disk_map, repeat([id], parse.(Int, n)))
            id += 1
        else
            push!(disk_map, repeat([-1], parse.(Int, n)))
        end
    end

    files = []
    for (i,f)=enumerate(disk_map)
        if all(f.>-1)
            push!(files, [i,f])
        end
    end

    free = []
    for (i,e) = enumerate(disk_map)
        if all(e.<0)
            push!(free, (i,e))
        end
    end

    j = length(files)
    used = 0
    while j>1
        f = files[j]
        j-=1
        file_len = length(f[2])
        if file_len == 0
            continue
        end

        for (i,e)=free
            f1 = f[1]
            if length(e) >= file_len && i<f1
                new_free = repeat([-1], file_len)
                disk_map[f1] = new_free
                disk_map[i] = f[2]

                if file_len<length(e)
                    insert!(disk_map, i+1, repeat([-1], length(e)-file_len))
                    files = [(fi>i ? fi+1 : fi,fe) for (fi,fe)=files]
                end

                free = []
                for (i,e) = enumerate(disk_map)
                    if all(e.<0)
                        push!(free, (i,e))
                    end
                end
                break
            end
        end
    end

    disk_map = vcat(disk_map...)
    s= 0
    i=-1
    for d=disk_map
        i+=1
        if d==-1
            continue
        end
        s+=i*d
    end
    println(s)
end
solve2(nums)
