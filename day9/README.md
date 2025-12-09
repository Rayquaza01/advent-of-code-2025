Woof.

Part 1 was really simple. Pick two points, make a rectangle, find the highest area.

Part 2 was basically impossible. I didn't finish it.

It looks like a grid puzzle, but that's bait, I think. The grid would be 100000x100000, so not reasonable. I figured out it actually wants to check that rectangle is all in bounds of the polygon. So, I made a function to check if a given point is on the polygon. I ran into a (literal) edge case, but other than that, it worked fine.

But the answer was wrong. So, I figured maybe I need to check the other corners. Nope, still wrong. How about the midpoint? Nah. Can I check every single point along the edge of the rectangle? No, takes too long. :/

Eventually, I start visualizing the problem. I start generating SVGs with my code. It's a circle with a giant slice taken out of it. I'm pretty sure one of the points *has* to be one of the ones on the slice. I even tried solving it by hand, and I still got it wrong! I don't know what I'm doing wrong.

- Part 1: 🪙 107 🕐️ 50ms
- Part 1: 🪙 DNF 🕐️ DNF
