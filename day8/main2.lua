local set_add = require("lib.array.set_add")

--- @param p1 table
--- @param p2 table
--- @return number
function distance(p1, p2)
	local x1, y1, z1 = table.unpack(p1)
	local x2, y2, z2 = table.unpack(p2)

	return math.sqrt(
		(z2 - z1) ^ 2 +
		(y2 - y1) ^ 2 +
		(x2 - x1) ^ 2
	)
end

local points = {}
local distances = {}

-- read in all the points into a table
for x, y, z in string.gmatch(io.read("a"), "(%d+),(%d+),(%d+)") do
	x, y, z = tonumber(x), tonumber(y), tonumber(z)
	table.insert(points, { x, y, z })
end

-- create a distances table that contains the distance between each pair of points
for i = 1, #points, 1 do
	for j = i + 1, #points, 1 do
		table.insert(distances, {distance(points[i], points[j]), i, j})
	end
end

local set_lookup = {}
local sets = {}

-- sort distances by shortest
table.sort(distances, function (a, b) return a[1] < b[1] end)

for i = 1, #distances, 1 do
	local dist, pointA, pointB = table.unpack(distances[i])
	-- print(string.format("Length: %0.2f between %d and %d", dist, pointA, pointB))

	-- Add a connection between points by putting them in sets
	-- 4 conditions
	-- neither A or B have any connections - create a new set, put them both in it
	-- A is connected, B isn't - put B into A's set
	-- B is connected, A isn't - put A into B's set
	-- A and B are both connected in different places - move all of B's set into A's set

	-- A-Set, You Bet!

	if set_lookup[pointA] == nil and set_lookup[pointB] == nil then
		sets[#sets + 1] = {}

		set_add(sets[#sets], pointA)
		set_add(sets[#sets], pointB)

		set_lookup[pointA] = #sets
		set_lookup[pointB] = #sets
	elseif set_lookup[pointA] ~= nil and set_lookup[pointB] == nil then
		set_lookup[pointB] = set_lookup[pointA]
		set_add(sets[set_lookup[pointA]], pointB)
	elseif set_lookup[pointA] == nil and set_lookup[pointB] ~= nil then
		set_lookup[pointA] = set_lookup[pointB]
		set_add(sets[set_lookup[pointB]], pointA)
	elseif set_lookup[pointA] ~= nil and set_lookup[pointB] ~= nil and set_lookup[pointA] ~= set_lookup[pointB] then
		local a_set = set_lookup[pointA]
		local b_set = set_lookup[pointB]

		for _, n in ipairs(sets[b_set]) do
			set_lookup[n] = a_set
			set_add(sets[a_set], n)
		end

		sets[b_set] = {}
	end

	if #sets[set_lookup[pointA]] == #points then
		local x1,y1,z1 = table.unpack(points[pointA])
		local x2,y2,z2 = table.unpack(points[pointB])

		print(string.format("(%d, %d, %d) and (%d, %d, %d)", x1, y1, z1, x2, y2, z2))
		print(x1 * x2)

		break
	end
end
