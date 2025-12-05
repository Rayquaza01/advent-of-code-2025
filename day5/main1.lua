total = 0

ranges = {}
--- @type string
input = io.read("a")

for min, max in string.gmatch(input, "(%d+)-(%d+)") do
	table.insert(ranges, {min=tonumber(min), max=tonumber(max)})
end

local separator = input:find("\n\n", 1, true) + 2
--- @cast separator integer

for num in string.gmatch(input:sub(separator), "(%d+)") do
	local n = tonumber(num)
	--- @cast n number

	-- print(n)
	for _, r in ipairs(ranges) do
		if n >= r.min and n <= r.max then
			total = total + 1
			break
		end
	end
end

print(total)
