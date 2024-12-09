line = readchomp("input.txt")
nums = [line...]

function map_disk(nums)
    disk_map = []
    id = 0
    for (i,n)=enumerate(nums)
        if i%2>0
            push!(disk_map, repeat([id],parse.(Int, n)))
            id += 1
        else
            push!(disk_map, repeat([-1], parse.(Int, n)))
        end
    end
    disk_map
end

disk_map = map_disk(nums)

function solve1(disk_map)
    disk_map=vcat(disk_map...)

    nempty=count(==(-1),disk_map)
    disk_map[disk_map.==-1] .= reverse(disk_map[disk_map.!=-1])[1:nempty]
    disk_map = disk_map[1:end-nempty]

    sum([0:length(disk_map)-1;].*disk_map)|>println
end
solve1(disk_map)

function solve2(disk_map)
    files = [(i,f) for (i,f)=enumerate(disk_map) if all(f.>1)]
    free = [(i,e) for (i,e)=enumerate(disk_map) if all(e.<0)]

    j = length(files)
    while j>1
        f = files[j]
        j -= 1
        file_len = length(f[2])
        file_len == 0 && continue

        for (i,e)=free
            f1 = f[1]
            free_len = length(e)
            if free_len >= file_len && i<f1
                disk_map[f1] = repeat([-1], file_len)
                disk_map[i] = f[2]

                if file_len<free_len
                    insert!(disk_map, i+1, repeat([-1], free_len-file_len))
                    files = [(fi>i ? fi+1 : fi, fe) for (fi, fe)=files]
                end

                free = [(i,e) for (i,e)=enumerate(disk_map) if all(e.<0)]
                break
            end
        end
    end

    s,i = 0, -1
    for d=vcat(disk_map...)
        i+=1
        d==-1 && continue
        s+=i*d
    end
    s |> println
end
solve2(disk_map)
