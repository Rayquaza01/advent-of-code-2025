sum = 0

--- Checks if an id is invalid.
--- If invalid, return it. If valid, return 0
--- @param idn number
--- @return number?
function check_invalid(idn)
	local id = tostring(idn)

	local length = #id
	local half = length // 2

	local first = id:sub(1, half)
	local second = id:sub(half + 1, length)

	if first == second then
		-- print(string.format("%s is invalid", id))
		return idn
	end

	return 0
end

for id1, id2 in string.gmatch(io.read("*a"), "(%d+)-(%d+)") do
	local ids, ide = tonumber(id1), tonumber(id2)

	for i = ids, ide, 1 do
		sum = sum + check_invalid(i)
	end
end

print(sum)
