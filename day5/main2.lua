-- 280612257071703 too low
-- 358659946022623 too high
-- 417391376945163 too high

total = 0

ranges = {}
--- @type string
input = io.read("a")

for min, max in string.gmatch(input, "(%d+)-(%d+)") do
	table.insert(ranges, {min=tonumber(min), max=tonumber(max)})
end

function in_range(n, min, max)
	return n >= min and n <= max
end

for i, r in ipairs(ranges) do
	for j, rs in ipairs(ranges) do
		if i == j then
			goto continue
		end

		if r.min == 0 or r.max == 0 or rs.min == 0 or rs.max == 0 then
			goto continue
		end

		if in_range(r.min, rs.min, rs.max) and in_range(r.max, rs.min, rs.max) then
			-- r is a subset of rs, so remove it
			r.min = 0
			r.max = 0
			-- print(string.format("%d is a subset of %d", i, j))
		elseif in_range(r.min, rs.min, rs.max) then
			-- r begins in rs, set it to start after
			r.min = rs.max + 1
			-- print(string.format("%d begins in %d", i, j))
		elseif in_range(r.max, rs.min, rs.max) then
			-- r ends in rs, set it to start before
			r.max = rs.min - 1
			-- print(string.format("%d ends in %d", i, j))
		end

		-- if r min is the same as rs min, combine them
		if r.min == rs.min then
			rs.max = math.max(r.max, rs.max)
			r.min = 0
			r.max = 0
			-- print(string.format("%d and %d have the same start", i, j))
		end

		-- if r max is the same as rs max, combine them
		if r.max == rs.max then
			rs.min = math.min(r.min, rs.min)
			r.min = 0
			r.min = 0
			-- print(string.format("%d and %d have the same end", i, j))
		end

		::continue::
	end
end

-- print()

for _, r in ipairs(ranges) do
	if r.min == 0 or r.max == 0 then
		print("Invalid")
	else
		print(string.format("%d-%d", r.min, r.max))
		total = total + (r.max - r.min) + 1
	end
end

print(total)
