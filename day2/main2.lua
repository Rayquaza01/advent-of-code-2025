sum = 0

--- Checks if an id is invalid.
--- If invalid, return it. If valid, return 0
--- @param idn number
--- @return number?
function check_invalid(idn)
	local id = tostring(idn)
	local len = #id

	-- determines the length of the partial string
	-- start at 0 (partial strings are 1 character long)
	-- go up to half the length (-1 because of zero indexing)
	for i = 0, len // 2 - 1, 1 do
		local repeated = true
		local start = 1

		-- iterate through each set of partial strings of length i
		-- if all of them match, then repeated will remain true
		-- and the id is invalid
		--
		-- if at least one part doesn't match, repeated will be false
		-- and the id is valid
		local prev = id:sub(start, start + i)
		while start <= len and repeated do
			local partial = id:sub(start, start + i)

			-- print(string.format("Partial: %s, Prev: %s", partial, prev))
			if partial ~= prev then
				-- print("Not repeated, valid")
				repeated = false
			end

			prev = partial
			start = start + i + 1
		end

		if repeated then
			-- print(string.format("%s is invalid", id))
			return idn
		end
	end

	return 0
end

for id1, id2 in string.gmatch(io.read("*a"), "(%d+)-(%d+)") do
	local ids, ide = tonumber(id1), tonumber(id2)

	for i = ids, ide, 1 do
		sum = sum + check_invalid(i)
	end
end

print(sum)
