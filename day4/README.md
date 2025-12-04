The first grid puzzle of the year! Time to break out my old grid handling functions!

For part 1, I just did one pass of the grid, and counted the number of rolls adjacent to each roll (`@`).

Part 2 was a little more tricky. I did one pass of the grid, taking note of the number of adjacent rolls. I stored those in a second copy of the grid. I then did two passes of that new grid. Once, removing the tiles that are <4, and once again decrementing the adjacent tiles. I stop once no <4 tiles remain.

I was expecting the part 2 one to take *much* longer, but it still got done in two tenths of a second!

(Quick note about token count. The token count is just the solution, and the one in parenthesis is the solution + the grid library.)

- Part 1: 🪙 131 (307), 🕐️ 40ms
- Part 2: 🪙 291 (467), 🕐️ 190ms
