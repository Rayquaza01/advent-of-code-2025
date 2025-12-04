Okay, I got a little confused with this one. I didn't realize that the IDs were a range. I just thought it was just two ids.

I started [drafting a post](https://github.com/Rayquaza01/advent-of-code-2025/blob/main/day2/draft) asking for help, but in the process of writing it out, I realized what I got wrong. Yay!

My initial thought was to do something like `(\d+)\1` maybe? (i.e. match a group followed by itself) But Lua doesn't have regex, it has Lua patterns. This is unfortunately not supported by Lua patterns, so I had to split the string in half the normal way.

In part 2, I do basically the same thing, but generalize it. I try and split the string into 1 character long sections, then 2, then 3, and so on. If all substrings match, then the string is "invalid" and therefore counted.

- Part 1: 🪙 83, 🕐️ 1.5s
- Part 2: 🪙 116, 🕐️ 5s

# BONUS

I had a fun idea: what if I could solve day 2 entirely in vim? Not vimscript, but like. *Interactively*.

The first step is expanding the ranges. I chose to do this by calling out to Lua.

`:%!lua -e 'for a,b in string.gmatch(io.read("a"), "(\%d+)-(\%d+)") do for i=tonumber(a), tonumber(b), 1 do print(i) end end'`

It's kinda complicated for a 1 liner, but it converts ranges into a list of all ids. *Maybe* this is cheating for the whole "do it interactively" thing, but doing it with a vim macro would be a massive pain.

Next, we grab all the "invalid" ids.

`:g/\v^(\d+)\1$/yank A` yanks all the invalid ids into the `a` register to be put in a different buffer.

`:g/\v^(\d+)\1+$/yank A` does the same, but for part 2.

Then, in the buffers with the invalid keys, I did `%s/\n/+` to join each line with a `+` (there's one extra at the end you need to remove!).

Finally, the answer can be achieved with `:%!bc`

And there we have it: Day 2 done *mostly* interactively.

Video Demo: https://www.youtube.com/watch?v=Yzehd6G-GJY
