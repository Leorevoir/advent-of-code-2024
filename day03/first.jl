result = 0

function exec_mul_instructions(first, second)
    global result

    result += first * second
end

function find_mul_instructions()
    local content = read("data.txt", String)

    # regex to match mul(number, number)
    for i in eachmatch(r"mul\((\d+),(\d+)\)", content)
        exec_mul_instructions(parse(Int, i.captures[1]), parse(Int, i.captures[2]))
    end
end

find_mul_instructions()
println("result: $result")
