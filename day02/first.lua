local file = io.open("data.txt", "r")

if not file then
    os.exit(84)
end

local array = {}
local safe = 0

for line in file:lines() do
    local row = {}
    for num in string.gmatch(line, "%S+") do
        table.insert(row, tonumber(num))
    end
    table.insert(array, row)
end

file:close()

local function is_safe_line(line)
    if #line < 2 then
        return false
    end

    local incr = nil

    for i = 1, #line - 1 do
        local diff = line[i + 1] - line[i]

        if math.abs(diff) > 3 then
            return false
        end

        if incr == nil then
            if diff > 0 then
                incr = true
            elseif diff < 0 then
                incr = false
            end
        end
        if (incr and diff <= 0) or (not incr and diff >= 0) then
            return false
        end
    end
    return true
end

for i = 1, #array do
    if is_safe_line(array[i]) then
        safe = safe + 1
    end
end

print(safe)
