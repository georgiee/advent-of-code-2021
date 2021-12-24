# Advent of Code 2021
Back this year after I skipped 2019. This year I'm ~thinking about using Ruby or Nim~ using Ruby again.
I have already blocked some time every day for 24 successive days to follow the riddle. 
Maybe this year I get to the 24th riddle, I always gave up before in the past events.

+ [Day 01](day-01/)
+ [Day 02](day-02/)
+ [Day 03](day-03/)
+ [Day 04](day-04/)
+ [Day 05](day-05/)
+ [Day 06](day-06/)
+ [Day 07](day-07/)
+ [Day 08](day-08/) (partial 🤡)
+ [Day 09](day-09/)
+ [Day 10](day-10/)
+ [Day 11](day-11/)
+ [Day 12](day-12/) (failed 💩)
+ [Day 13](day-13/)
+ [Day 14](day-14/) (partial 🤡)
+ [Day 15](day-15/) (partial 🤡)
+ [Day 16](day-16/)
+ [Day 17](day-17/)
+ [Day 18](day-18/) (failed,  I took the array bait instead of processing string 💩)
+ [Day 19](day-19/) (out of time 💩)
+ [Day 20](day-20/)
+ [Day 21](day-21/)
+ [Day 22](day-22/)
+ [Day 23](day-23/) (early stop 💩)
+ [Day 24](day-24/) (time is up, but it feels I'm super close)

## Neat things I learned
+ [Injecting](https://apidock.com/ruby/Enumerable/inject) is always super fun. I use `reduce` in JS sometimes and it was the basic instrument for AoC with Ruby
+ I used [numbered parameters](https://www.bigbinary.com/blog/ruby-2-7-introduces-numbered-parameters-as-default-block-parameters) (kind of anonymous parameters) a lot not to define variables names where I clearly know what's in there, especially for Aoc. I would not use them in production code to be honest. My code should always tell a story which they won't do.
+ Only on Day 23 I saw some code printing like that `p something` instead of `puts something`. I always wanted that over the course of 23 days of Ruby AoC 😅
+ [Enumerable#tally](https://ruby-doc.org/core-2.7.0/Enumerable.html) is such a nice tool to count things in an array.
+ `<=>` return -1,0 or zero to implement [Enumerable](https://ruby-doc.org/core-3.0.2/Enumerable.html) support. I knew that. But I didn't connect it to "walking directions" in a grid. You can do `dx = x2 <=> x1` and you get the correct sign to walk in the direction of x2 looking from x1. If there are on the same position the sign would be 0.
+ I know this from previous Aoc and other experiments with Ruby but handling different data formats binary, hex etc is super simple with Ruby. `to_s(2)` (number to binary, aka 0 and 1s), `to_i(16)` (hex string to number) and another nice finding `'%04b' % value` allows me to get padded binaries as otherwise the leading zeroes will be removed with `to_s` as they are not necessary.
+ On one day I used `NEIGHBORS = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]` to find all neighbours (including diagonal) and excluding the center. I found that while tinkering around with [Array#repeated_permutation](https://apidock.com/ruby/v2_5_5/Array/repeated_permutation), [Array#permutation](https://apidock.com/ruby/v2_5_5/Array/permutation) or [Array#combination](https://apidock.com/ruby/v2_5_5/Array/combination) which are useful helper to calculate variations. Pretty good for Aoc.
+ Hashes have `transform_keys` and `transform_values` which are handy to change them without a more complex `inject` setup. 
+ Ruby's stadnard library is just awesome. Whatever you need you probably will find it in [Array](https://apidock.com/ruby/Array), [Hash](https://apidock.com/ruby/Hash) or [Enumerable](https://apidock.com/ruby/Enumerable). One thing I loved the first time I found it was [Enumerable#each_cons](https://apidock.com/ruby/Enumerable/each_cons) which allows me to create a sliding window over an array super easy.
+ I always wonder why JS never got into such a state. That's so sad and part of the problem that the smallest things like `pad` needs to be fetched from `npm` 😐 It's so much more fun, then you think "hey maybe that's in the standard library" and you really find something (all the time with Ruby) versus the permanent frustration with JS where you already know it's not in there.
+ Regex. I always struggled to learn them, but I also had the motivation to learn them. For a few years (that also included many AoC years) I love regex. Together with regex101.com it's always a pleasure to build your patterns. This is always very useful for AoC even though you usually can parse any input usually with a few splits and joins.
+ Enumerator. I really wanted to use try them out and I used them on a few days lien on [Day 06](../day06) where I created a nice enumerator to calculate the fish life stream of data. It's the same as [JS generators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Generator) but it feels much more convenient in Ruby. Maybe that's because of AoC and you don't need the generator often in web projects with JS. On the other hand the awesome standard library makes it a fest to use in Ruby. I think that's the real reason I like them ❤️

I learned every day something, but that's enough for a list to wrap up AoC 2021.
