sum = 0

--- @param bank string
--- @return number?
function find_highest_pos(bank)
	local highest = 1
	for i = 2, #bank - 1, 1 do
		if bank:sub(highest, highest) < bank:sub(i, i) then
			highest = i
		end
	end

	local second = highest + 1
	for i = second, #bank, 1 do
		if bank:sub(second, second) < bank:sub(i, i) then
			second = i
		end
	end

	return tonumber(bank:sub(highest, highest) .. bank:sub(second, second))
end

for b in string.gmatch(io.read("a"), "(%d+)") do
	sum = sum + find_highest_pos(b)
end

print(sum)
