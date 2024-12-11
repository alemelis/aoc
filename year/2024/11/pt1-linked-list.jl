rocks = parse.(Int, split(readchomp("input.txt")))

mutable struct Node
    val::Int
    next::Union{Node, Nothing}
end
Node(v) = Node(v, nothing)

function link(rocks)
    dummy = Node(-1)
    tail = dummy
    for rock in rocks
        tail.next=Node(rock)
        tail = tail.next
    end
    dummy.next
end

head = link(rocks)

function blink!(head)
    tail = head
    c = 0
    while ~isnothing(tail)
        if tail.val == 0
            tail.val = 1
        elseif ndigits(tail.val)%2<1
            lx = parse.(Int, "$(tail.val)"[1:end÷2])
            rx = parse.(Int, "$(tail.val)"[end÷2+1:end])
            tail.val = lx
            node = Node(rx)
            node.next = tail.next
            tail.next = node
            tail = node
            c+=1
        else
            tail.val *= 2024
        end
        tail = tail.next
        c+=1
    end
    c
end