-- 11 ms

local start = 50

local password = 0

for dir, amount in string.gmatch(io.read("*a"), "(%a)(%d+)") do
	amount = tonumber(amount)
	if dir == "L" then
		start = (start - amount) % 100
	elseif dir == "R" then
		start = (start + amount) % 100
	end
	if start == 0 then
		password = password + 1
	end
	-- print(string.format("Direction: %s, Amount: %s, Position: %d", dir, amount, START))
end

print(password)
