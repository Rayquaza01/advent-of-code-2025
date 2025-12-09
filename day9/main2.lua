-- 4743537755 - too high
-- 4715842118 - too high
-- 4642129954 - too high
-- 4104445728 - wrong
-- 4071576600 - wrong
-- 1848886578 - wrong
-- 3208510560 - wrong

local points = {}
local sorted = {}
local p = ""
for x,y in string.gmatch(io.read("a"), "(%d+),(%d+)") do
	x, y = tonumber(x), tonumber(y)
	p = p .. x .. "," .. y .. " "
	table.insert(points, {x, y})
end

for _, point in ipairs(points) do
	table.insert(sorted, point)
end
table.sort(sorted, function(a,b)
	if a[2] < b[2] then
		return true
	end

	return false
end)

-- https://www.geeksforgeeks.org/dsa/how-to-check-if-a-given-point-lies-inside-a-polygon/#
local function point_in_polygon(x, y)
	local inside = false
	for i = 1, #points, 1 do
		local x1, y1 = table.unpack(points[i])
		j = i % #points + 1
		local x2, y2 = table.unpack(points[j])

		-- handle case where point is on edge
		if x >= math.min(x1, x2) and x <= math.max(x1, x2) and y == y1 and y1 == y2 then
			return true
		end

		if y >= math.min(y1, y2) and y <= math.max(y1, y2) and x == x1 and x1 == x2 then
			return true
		end

		if (y >= math.min(y1, y2)) then
			if (y <= math.max(y1, y2)) then
				if (x <= math.max(x1, x2)) then
					local x_intersection = ((y - y1) * (x2 - x1)) / (y2 - y1) + x1

					if (x1 == x2 or x <= x_intersection) then
						inside = not inside
					end
				end
			end
		end
	end

	return inside
end

-- if (y1 == 50372 or y2 == 50372 or y1 == 48373 or y2 == 48373) then
local function all_points_on_edges(x1, y1, x2, y2)
	for xvals = math.min(x1, x2), math.max(x1, x2) - 1, 1 do
		if not point_in_polygon(xvals, y1) then
			return false
		end
	end

	for yvals = math.min(y1, y2), math.max(y1, y2) - 1, 1 do
		if not point_in_polygon(x1, yvals) then
			return false
		end
	end

	return true
end

local function check_points(x1, y1, x2, y2)
	local width = math.abs(x2 - x1)
	local height = math.abs(y2 - y1)

	-- check opposite corners
	if point_in_polygon(x1, y2) and point_in_polygon(x2, y2) then
		-- check midpoint
		local xm = math.min(x1, x2) + width // 2
		local ym = math.min(y1, y2) + height // 2

		if point_in_polygon(x1, ym) and point_in_polygon(x2, ym) and point_in_polygon(xm, y1) and point_in_polygon(xm, y2) then
			-- check all points
			-- if all_points_on_edges(x1, y1, x2, y2) then
				return true
			-- end
		end
	end

	return false
end

local file = io.open("image.svg", "w")
if file == nil then
	os.exit()
end

file:write('<svg height="100000" width="100000" xmlns="http://www.w3.org/2000/svg">\n')

local max = 0
for i = 1, #sorted, 1 do
	print(string.format("%d / %d (%.2f%%)", i, #points, (i / #points) * 100))
	for j = 1, #acceptable_points, 1 do
		local x1, y1 = table.unpack(points[i])
		local x2, y2 = table.unpack(points[j])

		-- local top_left_x = math.min(x1, x2)
		-- local top_left_y = math.min(y1, y2)

		-- local bottom_right_x = math.max(x1, x2)
		-- local bottom_right_y = math.max(y1, y2)

		if y2 > y1 then
			-- if (y1 == 50372 or y2 == 50372 or y1 == 48373 or y2 == 48373) then
			local width = math.abs(x2 - x1) + 1
			local height = math.abs(y2 - y1) + 1

			local area = width * height
			if area > max then
				if check_points(x1, y1, x2, y2) then
					file:write(string.format('<rect x="%d" y="%d" width="%d" height="%d" stroke="blue" stroke-width="100" fill="none" />\n', math.min(x1, x2), math.min(y1, y2), width, height))
					-- if area > max then
					max = area
					print("New Max: " .. max)
				end
			end
		end


	end
end

file:write(string.format('<path d="M%s" stroke="red" stroke-width="100" fill="none" />\n', p))

file:write("</svg>\n")
file:close()

print(max)
