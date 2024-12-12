function parse_disk_map(filename::String)
    @inbounds content = read(filename, String)

    V::Vector{Int64} = [parse(Int, c) for c ∈ content if isdigit(c)]
    return V
end


function create_partitions(V::Vector{Int64})
    # pre-allocates Partition
    n = sum(V)
    Partition = Vector{Int64}(undef, n)

    idx = 1
    hash = 1

    # if odd, extend Partition else extend with -1
    @inbounds for (i, value) ∈ enumerate(V)
        block::Bool = isodd(i)
        fill!(@view(Partition[idx:idx+value-1]), block ? hash : -1)
        idx += value
        hash += block
    end

    return Partition
end


function move_blocks(Partition::Vector{Int64})
    # find first free_space index
    free_space = findfirst(isequal(-1), Partition)

    # reverse iteration
    @inbounds for i ∈ length(Partition):-1:1

        if Partition[i] != -1
            Partition[free_space] = Partition[i]
            Partition[i] = -1

            # find next free_space 
            free_space = findnext(isequal(-1), Partition, free_space + 1)
        end

        # break if no more free_space
        if i - free_space <= 1
            break
        end

    end

    return Partition
end


function check_sum(Partition::Vector{Int64})
    # -1 because stupid julia indexes at 1 and not 0...
    return sum((pos-1)*(id-1) for (pos, id) in pairs(Partition) if id != -1)
end


function main()
    Partition = create_partitions(parse_disk_map("data.txt"))

    println(check_sum(move_blocks(Partition)))
end


main()
