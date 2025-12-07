local g = require("lib.grid")

local start = {x=0, y=0}
local grid = {}

local row = 1
for line in string.gmatch(io.read("a"), "[^\n]+") do
	grid[row] = {}

	local col = 1
	for c in string.gmatch(line, ".") do
		grid[row][col] = { cell = c, visited = false }

		if c == "S" then
			start.x = col
			start.y = row
		end

		col = col + 1
	end

	row = row + 1
end

local WIDTH = #grid[1]
local HEIGHT = #grid

local beam_count = 0

local stack = {start}
while #stack > 0 do
	local top = table.remove(stack)
	local x, y = top.x, top.y
	-- print(string.format("Processing (%d, %d)", x, y))

	-- move beam downwards
	-- only process if in bounds and not previously visitied
	local ax, ay = g.find_adjacent(x, y, g.Directions.DOWN)
	if g.is_in_bounds(ax, ay, WIDTH, HEIGHT) and not grid[ay][ax].visited then
		grid[ay][ax].visited = true

		-- if cell is a splitter, try to split the beam to the left and right
		-- otherwise, just continue on

		if grid[ay][ax].cell == "^" then
			-- if split beam in bounds, and not visited
			-- increase beam count and add split beam
			-- if beam was already visited, skip it

			-- if a beam successfully split, increase local beam count
			-- if at least one beam was successfully split, increase global
			-- beam count

			local local_beam_count = 0
			local lx, ly = g.find_adjacent(ax, ay, g.Directions.LEFT)
			if g.is_in_bounds(lx, ly, WIDTH, HEIGHT) and not grid[ly][lx].visited then
				grid[ly][lx].visited = true
				table.insert(stack, {x=lx, y=ly})
				local_beam_count = local_beam_count + 1
			end

			local rx, ry = g.find_adjacent(ax, ay, g.Directions.RIGHT)
			if g.is_in_bounds(rx, ry, WIDTH, HEIGHT) and not grid[ry][rx].visited then
				grid[ry][rx].visited = true
				table.insert(stack, {x=rx, y=ry})
				local_beam_count = local_beam_count + 1
			end

			if local_beam_count > 0 then
				beam_count = beam_count + 1
			end
		else
			table.insert(stack, {x=ax, y=ay})
		end
	end
end

print(beam_count)
