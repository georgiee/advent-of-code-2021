require 'benchmark'

path = File.join(__dir__, 'input.txt')
input = *File.readlines(path).map {_1.chomp!}.map{ |row| row.split("").map{_1.to_i}}

# never started, failed in part 1
require 'benchmark'

path = File.join(__dir__, 'input.txt')
coordinates, instructions = *(File.read(path).split("\n\n"))

coordinates = coordinates.split("\n").map {_1.split(",").map(&:to_i)}
instructions = instructions.scan(/fold along (.)=(\d+)/)

def print(values, width = nil, height = nil)
  width = width || values.map{_1[0]}.max
  height = height ||  values.map{_1[1]}.max

  hash = values.inject(Hash.new('.')) do |hash, coordinate|
    hash[coordinate] = '#'
    hash
  end

  (height + 1).times do |y|
    line = (width + 1).times.collect do |x|
      hash[[x, y]]
    end
    puts line.join
  end
end

def reflect(value, reflection_point)
  return value if value < axis
  2 * reflection_point - value
end

def fold(values, amount, axis)
  values.map do |item|
    item = item.clone
    axis_accessor = axis == :x ? 0 : 1
    item[axis_accessor] = reflect(item[axis_accessor], amount)
    
    item
  end.uniq
end

result = instructions.inject(coordinates) do |memo, instruction|
  fold(memo, instruction[1].to_i, instruction[0].to_sym)
end

print(result)


