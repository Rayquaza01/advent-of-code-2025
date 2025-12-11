I'm back!

I took one look at the example data, and I thought, "There's gonna be loops!"

Part 1 was simple enough. Start at "you", and follow the paths until you get to end. It can be done really easily with a stack, and no loops! In the example, the only thing that leads to "you" is "aaa", but "aaa" is inaccessible, so no need to worry. Yet.

Part 2 got a little trickier. Very neat that the input data becomes more complex, just by changing the starting position. Starting from "you", it's fairly straightforward with no loops. But starting from "svr"...

So, I'm saying loops, but I don't think there are any actual loops. I did a couple test runs where I printed the depth of the paths, and I never saw the depth go above 33, so it wasn't actually looping. There's just a lot of *really* similar paths.

Anyway, I got the impression this is a prime candidate for memoization. And guess what? It was! Memoization made this *super* simple. I just rewrote it from a stack to a recursive function, added a memoizer table, and done in 18 milliseconds!

- Part 1: 🪙 110 🕐️ 11ms
- Part 2: 🪙 179 🕐️ 18ms
