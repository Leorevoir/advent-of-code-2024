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
    local function _is_line_safe(_line)
        if #_line < 2 then
            return false
        end

        local incr = nil

        for i = 1, #_line - 1 do
            local diff = _line[i + 1] - _line[i]

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

    if _is_line_safe(line) then
        return true
    end

    for i = 1, #line do
        local modified_line = {}
        for j = 1, #line do
            if j ~= i then
                table.insert(modified_line, line[j])
            end
        end

        if _is_line_safe(modified_line) then
            return true
        end
    end
    return false
end

for i = 1, #array do
    if is_safe_line(array[i]) then
        safe = safe + 1
    end
end

print(safe)
