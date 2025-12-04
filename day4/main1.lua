local grid = require("lib.grid")

warehouse = {}
accessible = 0

for line in string.gmatch(io.read("a"), "(%p+)\n") do
	table.insert(warehouse, {})
	for box in string.gmatch(line, "(%p)") do
		table.insert(warehouse[#warehouse], box)
	end
end

for y = 1, #warehouse, 1 do
	for x = 1, #warehouse[y], 1 do
		-- only check if a tile is accessible if it contains tp
		if warehouse[y][x] == "@" then
			local nearby_rolls = 0
			for d = 1, 8, 1 do
				local ax, ay = grid.find_adjacent(x, y, d)
				if grid.is_in_bounds(ax, ay, #warehouse[y], #warehouse) and warehouse[ay][ax] == "@" then
					nearby_rolls = nearby_rolls + 1
				end
			end

			-- io.write(nearby_rolls)

			if nearby_rolls < 4 then
				accessible = accessible + 1
			end
		else
			-- io.write(".")
		end
	end

	-- io.write("\n")
end

print(accessible)
