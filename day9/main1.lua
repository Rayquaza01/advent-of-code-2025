local points = {}
for x,y in string.gmatch(io.read("a"), "(%d+),(%d+)") do
	x, y = tonumber(x), tonumber(y)
	table.insert(points, {x, y})
end

local max = 0
for i = 1, #points, 1 do
	for j = i + 1, #points, 1 do
		local x1, y1 = table.unpack(points[i])
		local x2, y2 = table.unpack(points[j])

		local width = math.abs(x2 - x1) + 1
		local height = math.abs(y2 - y1) + 1

		local area = width * height
		if area > max then
			max = area
		end
	end
end

print(max)
