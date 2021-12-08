# Day 08

I gave up on part 2, I think I have the algorithm but time is running out, so I had to stop.

---

Ok part 1 was easy, finding the strign with a specific length and then map it to the actual value.
Part 2 reads really nice. My naive approach with the mapping of lengths comes to an end. I went to the
wikipedia page and checked the table for the seven digits panels. From this I have created a "standard map"
with the names from wikipedia:

```
SEVEN_SEGMENT_MAP = {
  1 => %i[b c],
  2 => %i[b d g],
  3 => %i[b c d g],
  4 => %i[b c f g],
  5 => %i[b c d f g],
  6 => %i[a c d f g],
  7 => %i[b c],
  8 => %i[b c d f g],
  9 => %i[b c d f g]
}.freeze
```

I then processed all values from the signal part and naively thought it's the same order. This failed of course. I felt I was minutes to the finish. Now it's 1 hour later and I feel depressed 😳
What happened? Well realizing the order is not guranteed (of course) I draw some digits and quickly came to some findings:

The digits of seven (a,b,c) and 1 (b,c) if subtracted yields a single segment. It's a, and now I know the mapping for the `a` wire.
Next I have to search for two digits that yield again a single digit. I though I'm smart not doing this manually and 
created a permutation(2) of the signal map to compare each signal with the other to filter the ones with a single digit difference
minus the known ones (`a`) (kind of removing from the equatio)

Next would be for example: 8 & 9: `[b c d e f g]` - `[b c d f g]` = `[e]` so I got the next wire pinned.
pool of good mappings are [`a`, `e`] which we can subtract from al remainings wires.
We are left with this:
```
SEVEN_SEGMENT_MAP = {
  1 => %i[b c],
  2 => %i[b d g],
  3 => %i[b c d g],
  4 => %i[b c f g],
  5 => %i[b c d f g],
  6 => %i[a c d f g],
  7 => %i[b c],
  8 => %i[b c d f g],
  9 => %i[b c d f g]
}.freeze
```
2 & 3 yields    [b c d g] - [b d g] = c
4 & 5 yields    [b c d f g] - [b c f g = d

known mappings are now [a, e, c, d]

```
SEVEN_SEGMENT_MAP = {
  1 => %i[b ],
  2 => %i[b g],
  3 => %i[b g],
  4 => %i[b f g],
  5 => %i[b f g],
  6 => %i[a f g],
  7 => %i[b],
  8 => %i[bf g],
  9 => %i[bf g]
}.freeze
```

Algorithm?
7 - 1 =>  [a,b,c] and 1 [b,c]  (store 'a' and remove a from everything else)
8 - 9 => `[b c d e f g]` - `[b c d f g]  (store 'e' and remove e from everything else)
2 - 3 => [b c d g] - [b d g]   (store 'c' and remove c from everything else)
4 -5 [b d f g] - [b f g]  (store 'd' and remove d from everything else)


## Learnings

## Instructions

```
--- Day 8: Seven Segment Search ---

You barely reach the safety of the cave when the whale smashes into the cave mouth, collapsing it. Sensors indicate another exit to this cave at a much greater depth, so you have no choice but to press on.

As your submarine slowly makes its way through the cave system, you notice that the four-digit seven-segment displays in your submarine are malfunctioning; they must have been damaged during the escape. You'll be in a lot of trouble without them, so you'd better figure out what's wrong.

Each digit of a seven-segment display is rendered by turning on or off any of seven segments named a through g:

  0:      1:      2:      3:      4:
 aaaa    ....    aaaa    aaaa    ....
b    c  .    c  .    c  .    c  b    c
b    c  .    c  .    c  .    c  b    c
 ....    ....    dddd    dddd    dddd
e    f  .    f  e    .  .    f  .    f
e    f  .    f  e    .  .    f  .    f
 gggg    ....    gggg    gggg    ....

  5:      6:      7:      8:      9:
 aaaa    aaaa    aaaa    aaaa    aaaa
b    .  b    .  .    c  b    c  b    c
b    .  b    .  .    c  b    c  b    c
 dddd    dddd    ....    dddd    dddd
.    f  e    f  .    f  e    f  .    f
.    f  e    f  .    f  e    f  .    f
 gggg    gggg    ....    gggg    gggg

So, to render a 1, only segments c and f would be turned on; the rest would be off. To render a 7, only segments a, c, and f would be turned on.

The problem is that the signals which control the segments have been mixed up on each display. The submarine is still trying to display numbers by producing output on signal wires a through g, but those wires are connected to segments randomly. Worse, the wire/segment connections are mixed up separately for each four-digit display! (All of the digits within a display use the same connections, though.)

So, you might know that only signal wires b and g are turned on, but that doesn't mean segments b and g are turned on: the only digit that uses two segments is 1, so it must mean segments c and f are meant to be on. With just that information, you still can't tell which wire (b/g) goes to which segment (c/f). For that, you'll need to collect more information.

For each display, you watch the changing signals for a while, make a note of all ten unique signal patterns you see, and then write down a single four digit output value (your puzzle input). Using the signal patterns, you should be able to work out which pattern corresponds to which digit.

For example, here is what you might see in a single entry in your notes:

acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
cdfeb fcadb cdfeb cdbaf

(The entry is wrapped here to two lines so it fits; in your notes, it will all be on a single line.)

Each entry consists of ten unique signal patterns, a | delimiter, and finally the four digit output value. Within an entry, the same wire/segment connections are used (but you don't know what the connections actually are). The unique signal patterns correspond to the ten different ways the submarine tries to render a digit using the current wire/segment connections. Because 7 is the only digit that uses three segments, dab in the above example means that to render a 7, signal lines d, a, and b are on. Because 4 is the only digit that uses four segments, eafb means that to render a 4, signal lines e, a, f, and b are on.

Using this information, you should be able to work out which combination of signal wires corresponds to each of the ten digits. Then, you can decode the four digit output value. Unfortunately, in the above example, all of the digits in the output value (cdfeb fcadb cdfeb cdbaf) use five segments and are more difficult to deduce.

For now, focus on the easy digits. Consider this larger example:

be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |
fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |
fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |
cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |
efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |
gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |
gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |
cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |
ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |
gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |
fgae cfgab fg bagce

Because the digits 1, 4, 7, and 8 each use a unique number of segments, you should be able to tell which combinations of signals correspond to those digits. Counting only digits in the output values (the part after | on each line), in the above example, there are 26 instances of digits that use a unique number of segments (highlighted above).

In the output values, how many times do digits 1, 4, 7, or 8 appear?

Your puzzle answer was 349.

The first half of this puzzle is complete! It provides one gold star: *
--- Part Two ---

Through a little deduction, you should now be able to determine the remaining digits. Consider again the first example above:

acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
cdfeb fcadb cdfeb cdbaf

After some careful analysis, the mapping between signal wires and segments only make sense in the following configuration:

 dddd
e    a
e    a
 ffff
g    b
g    b
 cccc

So, the unique signal patterns would correspond to the following digits:

    acedgfb: 8
    cdfbe: 5
    gcdfa: 2
    fbcad: 3
    dab: 7
    cefabd: 9
    cdfgeb: 6
    eafb: 4
    cagedb: 0
    ab: 1

Then, the four digits of the output value can be decoded:

    cdfeb: 5
    fcadb: 3
    cdfeb: 5
    cdbaf: 3

Therefore, the output value for this entry is 5353.

Following this same process for each entry in the second, larger example above, the output value of each entry can be determined:

    fdgacbe cefdb cefbgd gcbe: 8394
    fcgedb cgb dgebacf gc: 9781
    cg cg fdcagb cbg: 1197
    efabcd cedba gadfec cb: 9361
    gecf egdcabf bgf bfgea: 4873
    gebdcfa ecba ca fadegcb: 8418
    cefg dcbef fcge gbcadfe: 4548
    ed bcgafe cdgba cbgef: 1625
    gbdfcae bgc cg cgb: 8717
    fgae cfgab fg bagce: 4315

Adding all of the output values in this larger example produces 61229.

For each entry, determine all of the wire/segment connections and decode the four-digit output values. What do you get if you add up all of the output values?


```
