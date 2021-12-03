# Advent of Code 2021
Back this year after I skipped 2019. This year I'm ~thinking about using Ruby or Nim~ using Ruby again.
I have already blocked some time every day for 24 successive days to follow the riddle. 
Maybe this year I get to the 24th riddle, I always gave up before in the past events.

---

# Day 01
Easy start as usual and thanks to the large standard library in Ruby it was a pleasure to code mostly based on `each_cons`.
Once stupidity: I used `array.inject(&:+)` (and I was proud to know this shorcut) to summarize all numbers of an array. 
Looks like I should embrace Ruby more, because of this: `array.sum`. I'm sure I used this before but remembering this is hard
while coding daily in JavaScript where basically nothing is given by the standard toolbox.

# Day 02
Things stay simple. You get a command and a value which you need to split with a regex or whatever you find.
The nmap the command to actual operations. Some naive if blocks worked. For the second part the twist ist that the calculation
changes a little bit. It now involves aim and feels like the physics of velocity & acceleration model is slowly introduced.

I swapped the ifs for a more tidy `case` setup. After I submitted both results I came back to part 2 because
I wanted to pick up the `send` pattern I used together with the operands `&:+` and `&:-` and feed a class instead. The results looks awesome
because now I have a single in the line parser: `submarine.send(command, amount)` where send invokes a method with the given name.

# Day 03
Fuck me. This was difficult even thoguh I KNEW what it's about. `bit planes` or in generally bitwise operations. In the first parts I was smart enough to flip the bits of gamma to get epsilon.

The second part killed me. I forced myself to stay as naive as possible and keep handling the string
instead of using bitwise operations, I imagined shifting bits of gamma/epsilon and xoring them. 

When I was through first time I didn't check the result with the example set and hoped I'm done. I wasn't so it meant debugging time and  this time with the example set. I recognized that I did not update the bitplanes (gamme/epslion) after removing elements. Once I did that it was working for gamma. For epsilon I wanted to flip bits again but I was not sure about the contrains "keep 0 when the same" to I just copy pasted that part two. When run it was working and I got the final star. But boy, what a pain in the ass when you know where is some more elegant way.
