-- 3378 - too low

local g = require("lib.grid")

local start = {x=0, y=0}
local grid = {}

local row = 1
for line in string.gmatch(io.read("a"), "[^\n]+") do
	grid[row] = {}

	local col = 1
	for c in string.gmatch(line, ".") do
		grid[row][col] = c

		if c == "S" then
			start.x = col
			start.y = row
		end

		col = col + 1
	end

	row = row + 1
end

WIDTH = #grid[1]
HEIGHT = #grid

local memoizer = {}
for y = 1, HEIGHT, 1 do
	memoizer[y] = {}
end

local function follow_path(x, y)
	if memoizer[y][x] ~= nil then
		return memoizer[y][x]
	end

	local ax, ay = g.find_adjacent(x, y, g.Directions.DOWN)

	if g.is_in_bounds(ax, ay, WIDTH, HEIGHT) then
		if grid[ay][ax] == "^" then
			local res = 0
			local lx, ly = g.find_adjacent(ax, ay, g.Directions.LEFT)
			if g.is_in_bounds(lx, ly, WIDTH, HEIGHT) then
				res = res + follow_path(lx, ly)
			end

			local rx, ry = g.find_adjacent(ax, ay, g.Directions.RIGHT)
			if g.is_in_bounds(rx, ry, WIDTH, HEIGHT) then
				res = res + follow_path(rx, ry)
			end

			memoizer[y][x] = res
			return memoizer[y][x]
		else
			memoizer[y][x] = follow_path(ax, ay)
			return memoizer[y][x]
		end
	else
		memoizer[y][x] = 1
		return 1
	end
end

local oob_count = follow_path(start.x, start.y)

-- for y = 1, HEIGHT, 1 do
-- 	for x = 1, WIDTH, 1 do
-- 		if type(memoizer[y][x]) == "number" then
-- 			io.write(string.format("%02d ", memoizer[y][x] or 0))
-- 		else
-- 			io.write("   ")
-- 		end
-- 	end
-- 	io.write("\n")
-- end

print(oob_count)
