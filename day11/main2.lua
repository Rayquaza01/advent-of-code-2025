local device_map = {}

for line in string.gmatch(io.read("a"), "[^\n]+") do
	local devices = {}

	for device in string.gmatch(line, "(%a%a%a)") do
		table.insert(devices, device)
	end

	device_map[devices[1]] = {}
	for i = 2, #devices, 1 do
		table.insert(device_map[devices[1]], devices[i])
	end
end

-- for k, v in pairs(device_map) do
-- 	print(string.format("%s: %s", k, table.concat(v, ", ")))
-- end

local memoizer = {}
function find_paths(node, dac, fft)
	local id = string.format("%s%d%d", node, dac and 1 or 0, fft and 1 or 0)

	if memoizer[id] ~= nil then
		return memoizer[id]
	end

	-- if fft and dac were both visited, count 1 exit
	-- otherwise, count no exits
	if node == "out" then
		if fft and dac then
			memoizer[id] = 1
			return 1
		else
			memoizer[id] = 0
			return 0
		end
	end

	if node == "fft" then
		fft = true
	end

	if node == "dac" then
		dac = true
	end

	-- the exits of a node are equal to the sum of that node's children's exits
	-- we don't need to check for dac and fft here, because the children will
	local exits = 0
	for i = 1, #device_map[node], 1 do
		exits = exits + find_paths(device_map[node][i], dac, fft)
	end

	memoizer[id] = exits
	return exits
end

local paths = find_paths("svr", false, false)

-- print("Memoizer:")
-- for k, v in pairs(memoizer) do
-- 	print(string.format("%s: %d", k, v))
-- end

print(paths)
