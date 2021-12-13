require 'benchmark'

path = File.join(__dir__, 'input.txt')
coordinates, instructions = *(File.read(path).split("\n\n"))

coordinates = coordinates.split("\n").map {_1.split(",").map(&:to_i)}
instructions = instructions.scan(/fold along (.)=(\d+)/)


x = coordinates.map{_1[0]}.minmax
y = coordinates.map{_1[1]}.minmax

WIDTH = x[1]
HEIGHT = y[1]

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

def reflect_y(value, axis)
  return value if  value < axis
  
  d = value - axis
  axis - d
end

def reflect_x(value, axis)
  return value if  value < axis

  d = value - axis
  new_result = axis - d

  new_result
end

def fold_y(values, axis)
  #puts "fold along y #{axis}"
  values.map do |item|
    item = item.clone
    item[1] = reflect_y(item[1], axis)
    item
  end.uniq
end

def fold_x(values, axis)
  #puts "fold along x #{axis}"
  values.map do |item|
    item = item.clone
    item[0] = reflect_x(item[0], axis)
    item
  end.uniq
end

result = instructions.inject(coordinates) do |memo, instruction|
  if instruction[0] == 'y'
    fold_y(memo, instruction[1].to_i)
  else
    fold_x(memo, instruction[1].to_i)
  end
end

result = [instructions.first].inject(coordinates) do |memo, instruction|
  if instruction[0] == 'y'
    fold_y(memo, instruction[1].to_i)
  else
    fold_x(memo, instruction[1].to_i)
  end
end

puts "part 1: result.size"

result = instructions.inject(coordinates) do |memo, instruction|
  if instruction[0] == 'y'
    fold_y(memo, instruction[1].to_i)
  else
    fold_x(memo, instruction[1].to_i)
  end
end

puts "part 2"
print(result)


