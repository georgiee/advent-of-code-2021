# found afterwards, that's so neat
# 1. Numbered parameters for blocks saves you to define variables for simple operations (see https://ruby-doc.org/core-2.7.0.rc2/Proc.html)
# 2. I totally forgot about the sum method for arrays and instead did a proud `inject(&:+)`. Being aware of this will help in the following days.
# 3. I'm sure I used count before on array, but that passing in a block to filter elements is a thing, that's new, also nice!
path = File.join(__dir__, 'input.txt')
input = File.read(path).split.map(&:to_i)

puts input.each_cons(2).count{ _2 > _1 }
puts input.each_cons(3).map(&:sum).each_cons(2).count{ _2 > _1 }

