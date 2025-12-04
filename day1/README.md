I'm doing Lua again this year. Not Picotron Lua, but I have it and Love2d on standby if I want to make a visualization for some days.

Part 1 was pretty easy: read in the file, extract the directions and amounts (which Lua makes really easy with `string.gmatch`!), and add them. If it's exactly zero, add 1 to the password.

I got a little stuck on part 2. It's the same general principle, but this time count how many times it passes 0. I would think it would be as simple as `math.ceil(amount / 100)`, but there must be some edge case I'm not seeing. After 7 wrong guesses, I ended up just doing the naive solution (incrementing/decrementing the position `amount` times).

Execution times:
- Part 1: 11ms
- Part 2: 28ms
