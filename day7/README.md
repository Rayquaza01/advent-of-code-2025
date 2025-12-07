Yet another grid puzzle, and this time with beam splitting!

Part 1 was pretty simple. Just put the beam head in a stack, and process its path. If a tile is unvisited and in bounds, push it to the stack for processing. If a tile is a splitter, push both the left and the right. I keep track of what tiles are visited, and don't process a beam if it's already been marked as visited.

The beam counting was a *little* tricky. If a splitter tries to push a beam onto a tile where a beam already exists, it doesn't do anything. But if it can push *at least one* beam, then it's counted. So the number 21 in the example comes from the fact that 1 of the 22 beams is blocked on both sides.

Part 2 wants to know the total number of times the beam finishes (goes out of bounds), including repeats. So, I got rid of the visited check and beam counting code, and yeah. There's too many. So *now* is the time for memoization! I rewrote my stack code as a recursive function so I can memoize it. (I mean, I'm sure I could do it with it as a stack, but I find memoization easier to do with recursive functions.)

- Part 1: 🪙 299 (475) 🕐️ 30ms
- Part 2: 🪙 263 (439) 🕐️ 20ms
