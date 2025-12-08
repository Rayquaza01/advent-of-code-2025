It's kinda weird to think we're coming up on the end on Friday. They're definitely getting trickier. This is the first one since day 2 that took over a second to run for me. Hopefully, I'll be able to keep up!

Lookup tables/indirection were the name of the game on this one. For part 1, I made 4 main tables.

1. The points table, containing all of the points.
2. The distances table, which contains the distances between each pair of points and their indices.
3. The sets table, which contains a list of sets, each containing indices for the points inside it.
4. The set lookup table, which allows you to lookup what set a given point is in.

I ran through 1000 distances, sorted by shortest, adding each of the pair of points to sets as I went. If neither were in a set, a new set was made. If one was in a set, the other was added to the pre-existing set. If both were in different sets, the sets were merged.

Finally, the sets were sorted by length, and the top 3 were multiplied together to get the answer.

Part 2 wasn't all that much harder. Instead of stopping at 1000 connections, we keep going until everything is connected. I check for that by comparing the length of the set (there's only one in the final step!) and the points table. When they're the same length, I stop and multiply the x coordinates of the last two points.

- Part 1: 🪙 367 (423) 🕐️ 1.4s
- Part 2: 🪙 373 (429) 🕐️ 1.4s
