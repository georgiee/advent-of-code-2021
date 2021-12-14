require 'benchmark'

path = File.join(__dir__, 'input.txt')
template, insertions = *(File.read(path).split("\n\n"))
insertions = insertions.scan(/(.{2}) -> (.)/).to_h


def unfold(template, insertions)
  current_template = template
  
  Enumerator.new do |yielder|
    loop do
      next_value = current_template.chars.each_cons(2).inject([]) do |memo, pair|
        if insertions.key?(pair.join)
          insertion = insertions[pair.join]
          value = pair.join.insert(1, insertion)
          memo << value
        end
        memo
      end
      
      # remove overlays
      next_value = next_value.each_with_index.map do |item, index|
        item = item[0..-2] if index < next_value.size - 1
        item
      end.join

      yielder << next_value

      current_template = next_value
    end
    
  end
end



puts Benchmark.measure {
  unfolder = unfold(template, insertions)
  result = unfolder.take(10).last
  result = result.chars.tally.minmax_by {|k, v| v}
  min, max = result

  puts "found min: #{min.first} with #{min.last} occurences"
  puts "found nax: #{max.first} with #{max.last} occurences"

  puts "part 1 result is: #{max.last - min.last}"
}

