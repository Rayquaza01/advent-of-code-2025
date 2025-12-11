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

local paths = 0

local stack = {"you"}
while #stack > 0 do
	local top = table.remove(stack)
	if top == "out" then
		paths = paths + 1
	else
		for i = 1, #device_map[top], 1 do
			table.insert(stack, device_map[top][i])
		end
	end
end

print(paths)
