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
