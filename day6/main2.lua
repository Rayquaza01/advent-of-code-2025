--- Transposes a matrix
--- https://www.geeksforgeeks.org/dsa/program-to-find-transpose-of-a-matrix/
--- @param mat table
--- @return table
function transpose(mat)
	local rows = #mat
	local cols = #mat[1]

	local tMat = {}
	for i = 1, cols, 1 do
		tMat[i] = {}
	end

	for i = 1, rows, 1 do
		for j = 1, cols, 1 do
			tMat[j][i] = mat[i][j]
		end
	end

	return tMat
end

sum = 0

input = io.read("a")

-- read in the text as a grid
text_grid = {}
for line in string.gmatch(input, "[^\n]+") do
	table.insert(text_grid, {})
	for char in string.gmatch(line, ".") do
		table.insert(text_grid[#text_grid], char)
	end
end

-- transpose the text grid, and convert it to a string
rotated_string = ""
rotated_grid = transpose(text_grid)
for y = 1, #rotated_grid, 1 do
	for x = 1, #rotated_grid[y], 1 do
		rotated_string = rotated_string .. rotated_grid[y][x]
		-- io.write(rotated_grid[y][x])
	end
	rotated_string = rotated_string .. "\n"
	-- io.write("\n")
end

ops = {}
for op in string.gmatch(rotated_string, "(%p)") do
	table.insert(ops, op)
end

eqs = {}
for i = 1, #ops, 1 do
	eqs[i] = {}
end

count = 1
for line in string.gmatch(rotated_string, "([^\n]+)\n") do
	-- strip non digit characters from number
	-- if n is nil, then it's a blank line, marking the separation between equations
	local n = tonumber(line:gsub("[^%d]", ""), 10)
	if n ~= nil then
		table.insert(eqs[count], n)
	else
		count = count + 1
	end
end

for i, op in ipairs(ops) do
	subtotal = eqs[i][1]
	for j = 2, #eqs[i], 1 do
		if op == "+" then
			subtotal = subtotal + eqs[i][j]
		elseif op == "*" then
			subtotal = subtotal * eqs[i][j]
		end
	end

	sum = sum + subtotal
end

print(sum)
