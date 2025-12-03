NUMBER_OF_BATTERIES = 12

sum = 0

--- @param bank string
--- @return number?
function find_highest_pos(bank)
	local last_highest = 0
	local turn_on = {}

	for limit = NUMBER_OF_BATTERIES - 1, 0, -1 do
		local highest = last_highest + 1
		for i = highest + 1, #bank - limit, 1 do
			if bank:sub(highest, highest) < bank:sub(i, i) then
				highest = i
			end
		end

		last_highest = highest
		table.insert(turn_on, bank:sub(highest, highest))
	end

	return tonumber(table.concat(turn_on, ""))
end

for b in string.gmatch(io.read("a"), "(%d+)") do
	sum = sum + find_highest_pos(b)
end

print(sum)
