sum = 0

input = io.read("a")

ops = {}
for op in string.gmatch(input, "%p") do
	table.insert(ops, op)
end

eqs = {}
for i = 1, #ops, 1 do
	eqs[i] = {}
end

count = 0
for n in string.gmatch(input, "(%d+)") do
	table.insert(eqs[count + 1], tonumber(n))
	count = (count + 1) % #ops
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
