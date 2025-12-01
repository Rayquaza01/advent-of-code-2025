-- 2228 too low
-- 5205 too low
-- 5579 too low
-- 5669 wrong
-- 6348 wrong
-- 6064 wrong
-- 5956 wrong

-- 28 ms

local start = 50
local position = start

local password = 0

for dir, amount in string.gmatch(io.read("*a"), "(%a)(%d+)") do
	start = position

	amount = tonumber(amount)
	for i = 1, amount, 1 do
		if dir == "L" then
			position = position - 1
		elseif dir == "R" then
			position = position + 1
		end

		if position < 0 then
			position = 99
		elseif position > 99 then
			position = 0
		end

		if position == 0 then
			password = password + 1
		end
	end

	-- Mod solution, not working

	-- if dir == "L" then
	-- 	position = (position - amount)
	-- elseif dir == "R" then
	-- 	position = (position + amount)
	-- end

	-- if position <= 0 or position > 99 then
	-- 	if start == 0 and amount < 99 then
	-- 		-- do nothing, already counted when landed on zero
	-- 	else
	-- 		local pass = math.ceil(amount / 100)
	-- 		print(string.format("Passed zero %d times", pass))
	-- 		password = password + pass
	-- 	end
	-- end

	-- position = position % 100

	-- print(string.format("Direction: %s, Amount: %s, Position: %d", dir, amount, position))
end

print(password)
