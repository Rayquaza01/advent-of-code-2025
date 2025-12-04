local grid = require("lib.grid")

warehouse = {}
removed = 0
warehouse_counts = {}

for line in string.gmatch(io.read("a"), "(%p+)\n") do
	table.insert(warehouse, {})
	for box in string.gmatch(line, "(%p)") do
		table.insert(warehouse[#warehouse], box)
	end
end

for y = 1, #warehouse, 1 do
	warehouse_counts[y] = {}
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

			warehouse_counts[y][x] = nearby_rolls
		else
			warehouse_counts[y][x] = "."
		end
	end
end

repeat
	local_accessible = 0
	for y = 1, #warehouse_counts, 1 do

		for x = 1, #warehouse_counts[y], 1 do
			-- io.write(warehouse_counts[y][x])

			if type(warehouse_counts[y][x]) == "number" and warehouse_counts[y][x] < 4 then
				local_accessible = local_accessible + 1
				removed = removed + 1

				warehouse_counts[y][x] = "X"
			end
		end
		-- io.write("\n")
	end
	-- print(removed)

	for y = 1, #warehouse_counts, 1 do
		for x = 1, #warehouse_counts[y], 1 do
			if warehouse_counts[y][x] == "X" then
				warehouse_counts[y][x] = "."

				for d = 1, 8, 1 do
					local ax, ay = grid.find_adjacent(x, y, d)
					if grid.is_in_bounds(ax, ay, #warehouse_counts[y], #warehouse_counts) and type(warehouse_counts[ay][ax]) == "number" then
						warehouse_counts[ay][ax] = warehouse_counts[ay][ax] - 1
					end
				end
			end
		end
	end
until local_accessible < 1

print(removed)
