require 'benchmark'

path = File.join(__dir__, 'input.txt')
template, insertions = *(File.read(path).split("\n\n"))
insertions = insertions.scan(/(.{2}) -> (.)/).to_h
insertions = insertions.each_with_object({}) do |(k, v), hash|
  hash[k] = k.dup.insert(1, v)
end

def process(current_template, insertions)
  pairs = current_template.chars.each_cons(2)
  
  next_value = pairs.each_with_index.inject("") do |memo, value|
    pair, index = value
    
    if insertions.key?(pair.join)
      insertion = insertions[pair.join]
      value = insertion[0..-2]
      next memo + value
    end
    
    memo
  end
  
  next_value + current_template.chars.last
end

insertions

def unfold(template, insertions, count)
  current = template
  count.times do |index|
    puts "processing step #{index}"
    current = process(current, insertions)
  end

  current
end



# lol I should stop try to improve the performance recognizing that there would be an array if 2192039569602 B's and 3849876073 H's
# in the example. That's  huge.

# there must be a solution where I can just work on the numbers/frequencies
# or some way to collapse the polymer and storing the numbers in between
# I have also checked the output of the example. it's NBBNBBNBBNBBNBBNBBNBBNBBNBBNBBNBBNBB everywhere
# which tells me that this must be representable as NBB with a numbers

# alternative ideas: unfold the insertions itself somehow? (kind of a cipher) 
# alternative ideas: compress the results an only work on "triples of data"?



result = unfold2 unfold(template, insertions, 1)
result = result.chars.tally.minmax_by {|k, v| v}
min, max = result

puts "found min: #{min.first} with #{min.last} occurences"
puts "found nax: #{max.first} with #{max.last} occurences"

puts "part 1 result is: #{max.last - min.last}"
