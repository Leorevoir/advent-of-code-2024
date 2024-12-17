module day09

    function parse_disk_map(filename::String)
        @inbounds content = read(filename, String)

        V::Vector{Int} = [parse(Int, c) for c ∈ content if isdigit(c)]
        return V
    end


    function create_partitions(V::Vector{Int}, n::Int)
        # pre-allocates Partitions
        PartitionP1 = Vector{Int}(undef, n)
        PartitionP2 = Vector{Tuple{Int, Int, Int}}(undef, 0)
        Gaps = Vector{Tuple{Int, Int}}(undef, 0)

        idx = 1
        hash = 1
        cumulative_lengths = accumulate(+, V; init=0)

        # if odd, extend Partition else extend with -1
        @inbounds for (i, value) ∈ enumerate(V)
            block::Bool = isodd(i)

            if block
                push!(PartitionP2, (idx-1, hash-1, value))
                fill!(@view(PartitionP1[idx:idx+value-1]), hash)
                hash += block
            else
                push!(Gaps, (value, cumulative_lengths[i-1]))
                fill!(@view(PartitionP1[idx:idx+value-1]), -1)
            end

            idx += value
        end

        return PartitionP1, PartitionP2, Gaps
    end


    function move_blocks(Partition::Vector{Int})
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


    function move_files!(
        P1::Vector{Int},
        P2::Vector{Tuple{Int, Int, Int}},
        Gaps::Vector{Tuple{Int, Int}})

        # iterate on blocks
        @inbounds for i ∈ length(P2):-1:1
            start_idx, file_id, file_length = P2[i]

            @inbounds for (gap_idx, (gap_length, gap_position)) ∈ enumerate(Gaps)

                gap_position > start_idx && break

                # ensure gap is big enough for the block
                if gap_length >= file_length
                    for l in 1:file_length

                        P1[start_idx + l] = -1
                        # file_id + 1 because julia indexes at 1 and not 0
                        # and we are already -1 on Partition in check_sum
                        P1[gap_position + l] = file_id + 1

                    end

                    # update gaps length
                    diff = gap_length - file_length
                    if diff > 0
                        Gaps[gap_idx] = (diff, gap_position + file_length)
                    else
                        deleteat!(Gaps, gap_idx)
                    end

                    # break gaps loop after the move
                    break

                end

            end

        end

        return P1
    end


    function check_sum(Partition::Vector{Int})
        # -1 because stupid julia indexes at 1 and not 0...
        return sum((pos-1)*(id-1) for (pos, id) in pairs(Partition) if id != -1)
    end


    function main()
        V::Vector{Int} = parse_disk_map("data.txt")
        n::Int = sum(V)

        P1, P2, Gaps = create_partitions(V, n)
        # as move_blocks and move_files modify the vector
        # i just made a copy of the base partition vector
        Base::Vector{Int} = P1[:]

        println("part1: ", check_sum(move_blocks(P1)))
        println("part2: ", check_sum(move_files!(Base, P2, Gaps)))
    end

    main()

end # module day09
