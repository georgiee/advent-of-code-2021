# 1. atan2 is a smart idea for the slope and could help getting rid of the dx/dy mess
# see https://www.reddit.com/r/adventofcode/comments/r9824c/2021_day_5_solutions/hnapro6/

# 2. R/Slotch was impressive
# see https://www.reddit.com/r/adventofcode/comments/r9824c/2021_day_5_solutions/hnaqljt/

# 3. Standard Libraries
# See so many people with languages that have a great math standard library (numpy for example)
# it might help to use http://sciruby.com/ ?

# 4. Numeric 1 <=> 2 returns -1, 0, +1 or nil 😍
# See https://ruby-doc.org/core-2.5.0/Integer.html#method-i-3C-3D-3E
# Via ruby code golfed (https://www.reddit.com/r/adventofcode/comments/r9824c/2021_day_5_solutions/hnaltum/)

# here the ungolfed version of the linked solution. 
# I know of <=> being part of the enumerator implmenetation
# but I did not connect the lines to maek use of the return value of that operator. 
# So good!
# 
# path = File.join(__dir__, 'input.txt')
# input = File.read(path).split("\n")
#
# q = Hash.new 0
# input.map do |l|
#   a, b, c, d = l.scan(/\d+/).map(&:to_i)
#   e = c <=> a
#   f = d <=> b
#   until [a,b] == [c+e, d+f] do
#     q[[a, b]] += 1
#     a += e
#     b += f
#   end
# end
#
# p q.count{_2>=2}
