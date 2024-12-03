result = 0

function exec_mul_instructions(match)
    global result
    local first = parse(Int, match.captures[1])
    local second = parse(Int, match.captures[2])

    println("$first * $second")
    result += first * second
end

function find_all_instructions()
    local content = read("data.txt", String)
    local enabled = true

    local r_mul = r"mul\((\d+),(\d+)\)"
    local r_do = r"do\(\)"
    local r_dont = r"don't\(\)"

    # get all possible regex matches
    for match in eachmatch(r"(mul\(\d+,\d+\)|do\(\)|don't\(\))", content)

        instr = match.match

        # check if do() or don't()
        if occursin(r_do, instr)
            enabled = true
        elseif occursin(r_dont, instr)
            enabled = false
        end

        # check if mul(number, number)
        if enabled && occursin(r_mul, instr)
            mul_match = collect(eachmatch(r_mul, instr))[1]
            exec_mul_instructions(mul_match)
        end

    end
end

find_all_instructions()
println("result: $result")
