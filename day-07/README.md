# Day 07
Waiting for Day 7 to begin. I'm checking the [rockstar documentation](https://codewithrockstar.com/docs) to get amused.

--

Ok I was SUPER fast for part 1 but then part 2 got me like Day 6 got me: It was running forever. This time I had no immediate clue what was wrong. I tinkered around with the range which I calculated as `range = (input.min..input.max)` so covering the entire x-axis where the crabs are hanging around. In part 1 I was lucky and I could use `input.compact.uniq` instead but this is not working here as we might miss some ideal positions (like the `5` from the example).

So what now? Let's optimize in a classical way, maybe the code runs slow for all the given permutations. I was using `key.downto(1).inject(:+)` to add up the numbers. That's expensive so what do you do ? Cache it. I used the great `default_proc` fucntionality of the ruby hash. That's a proc invoked for not existing keys. That way I can calculate values for a new key and return previous calculations directly without calculation.
`TRIANGLE_CACHE.default_proc = proc { |hash, key| hash[key] = key.downto(1).inject(:+) }`

This was the first time it worked with painful 6 or so seconds.

I submitted the result but I wanted to see if I can bring that number down.
When I searched for `factorial but with addition` I came across the triangle numbers which are familiar to me from statistics (but my mind did not conclude this before google). So instead of adding up all numbers manually I can shortcut and do the math with `n*(n+1)/2` 🤘 I removed the cache and replaced it with the direct calculation. It's now 2.7 seconds.

If I bring back the hash cache, I can shave another 0.75s probably because of the shear amount of permutations I'm processing.
I had some ideas for precalculate all permutations to remove duplicates, then calculate and the group the results back to the specific positions to add them up again. But my stamina is gone for this day. 

So it's 1.9s.

## Learnings

## Instructions

```
--- Day 7: The Treachery of Whales ---

A giant whale has decided your submarine is its next meal, and it's much faster than you are. There's nowhere to run!

Suddenly, a swarm of crabs (each in its own tiny submarine - it's too deep for them otherwise) zooms in to rescue you! They seem to be preparing to blast a hole in the ocean floor; sensors indicate a massive underground cave system just beyond where they're aiming!

The crab submarines all need to be aligned before they'll have enough power to blast a large enough hole for your submarine to get through. However, it doesn't look like they'll be aligned before the whale catches you! Maybe you can help?

There's one major catch - crab submarines can only move horizontally.

You quickly make a list of the horizontal position of each crab (your puzzle input). Crab submarines have limited fuel, so you need to find a way to make all of their horizontal positions match while requiring them to spend as little fuel as possible.

For example, consider the following horizontal positions:

16,1,2,0,4,2,7,1,2,14

This means there's a crab with horizontal position 16, a crab with horizontal position 1, and so on.

Each change of 1 step in horizontal position of a single crab costs 1 fuel. You could choose any horizontal position to align them all on, but the one that costs the least fuel is horizontal position 2:

    Move from 16 to 2: 14 fuel
    Move from 1 to 2: 1 fuel
    Move from 2 to 2: 0 fuel
    Move from 0 to 2: 2 fuel
    Move from 4 to 2: 2 fuel
    Move from 2 to 2: 0 fuel
    Move from 7 to 2: 5 fuel
    Move from 1 to 2: 1 fuel
    Move from 2 to 2: 0 fuel
    Move from 14 to 2: 12 fuel

This costs a total of 37 fuel. This is the cheapest possible outcome; more expensive outcomes include aligning at position 1 (41 fuel), position 3 (39 fuel), or position 10 (71 fuel).

Determine the horizontal position that the crabs can align to using the least fuel possible. How much fuel must they spend to align to that position?

The first half of this puzzle is complete! It provides one gold star: *
--- Part Two ---

The crabs don't seem interested in your proposed solution. Perhaps you misunderstand crab engineering?

As it turns out, crab submarine engines don't burn fuel at a constant rate. Instead, each change of 1 step in horizontal position costs 1 more unit of fuel than the last: the first step costs 1, the second step costs 2, the third step costs 3, and so on.

As each crab moves, moving further becomes more expensive. This changes the best horizontal position to align them all on; in the example above, this becomes 5:

    Move from 16 to 5: 66 fuel
    Move from 1 to 5: 10 fuel
    Move from 2 to 5: 6 fuel
    Move from 0 to 5: 15 fuel
    Move from 4 to 5: 1 fuel
    Move from 2 to 5: 6 fuel
    Move from 7 to 5: 3 fuel
    Move from 1 to 5: 10 fuel
    Move from 2 to 5: 6 fuel
    Move from 14 to 5: 45 fuel

This costs a total of 168 fuel. This is the new cheapest possible outcome; the old alignment position (2) now costs 206 fuel instead.

Determine the horizontal position that the crabs can align to using the least fuel possible so they can make you an escape route! How much fuel must they spend to align to that position?


```
