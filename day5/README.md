This was a tricky one! At least I noticed that it says range this time! :)

The first part was simple enough. Read in all the ranges, then read in all the numbers, test the numbers against the ranges, ezpz!

The second part, my initial read on it was to use memoization. That *technically* would work, but it would be little better than brute force. The problem is *every* possible value is fresh (because we're checking from the ranges themselves, not the input data). What it really wants is `max - min + 1`, but some of the ranges overlap, causing duplicates to be counted.

There was a problem with merging ranges either last year or the year before, and I never figured it out. IIRC, I just brute forced that one. But this one, that's not really viable. So, I have to merge the ranges together. I came up with 5 cases for merging the ranges:

1. `r1` is a subset of `r2`, so `r1` should be invalidated
2. `r1` starts in `r2`, so `r1`'s min should be set to `r2`'s max + 1
3. `r1` ends in `r2`, so `r1`'s max should be set to `r2`'s min - 1
4. `r1` starts at the same point as `r2`, so `r1` should be invalidated and `r2`'s max should be set to the larger max between the two
5. `r1` ends at the same point as `r2`, so `r1` should be invalidated and `r2`'s min should be set to the smaller min between the two

After a little bit of fiddling with it (and a mistake where I accidentally put a `goto` label in the wrong place...), it works! (I'm using `goto` at one point because Lua doesn't have a `continue` statement.)

`vimdiff` was very helpful to see how the list was changed! Once I modified the list, I could print out the new copy and diff it with the original, to make sure all the changes make sense.

- Part 1: 🪙 92, 🕐️ 25ms
- Part 2: 🪙 257, 🕐️ 25ms
