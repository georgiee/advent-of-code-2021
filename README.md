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

# Day 04
This was a nice challenge. I directly had a strategy in my mind. It's not beautiful but straight forward. But first
I struggled to parse the input. I desperately wanted to find a built-in method to get groups of 5 lines (the boards)
and I was sure there is some "groups_of" but this time I was disappointed as ths is only part of rails. Anyway `each_with_index`, `inject` and a modulo helped here. Once I had this I didn't want to handle all those arrays instead I diveded and conquored: I created a class for each board.

That helped my mind I could focus on the actual problem dealing with a single board. Here I remembered finallyl the awesomeness of ruby.
I can subtract arrays to remove existing elements. I can now simply subtract the drawn numbers from the numbers per row and column and 
if any of that is empty I have a match. In the same manner I can find the unmarked numbers.

The only thing I had to do was to store the numbers in a transposed way to access distinct columns besides the rows. And then I got the result as I can simply go through the drawn numbers in increasing windows and check that windows towards all boards

```
def wins?(draw)
    @rows.any? { |row| (row - draw).empty? } || @columns.any? { |columns| (columns - draw).empty? }
  end
```

I used `detect` on my boards array to find the first winner and calculating the result.
In part 2 it was basically an exercise of letting my algorithm run and store the winning boards. 
Once all boards where winnerns I checked the current numbers and so on.

One problem here was the usage of `detect` which will not work if multiple boards win within a round. I debugged for from frustrating minutes and then got the idea to use `select`. Phew! 

Nice day!
