require 'benchmark'

file_content = File.read(File.join(__dir__, 'input.txt'))
input = file_content.each_line.map {_1.chomp.chars.map(&:to_i)}

t = input.transpose

def move_right(grid, dx)
  grid.map do |line|
    line.map{(_1 + dx) % 10}
  end
end

def move_down(grid, dy)
  grid.transpose.map do |line|
    line.map{(_1 + dy) % 10}
  end.transpose
end

def move(grid, dx, dy)
  grid = move_right(grid,dx)
  move_right(grid, dy)
end

res = 5.times.inject([]) do |memo, y|
  5.times do |x|
    abc = move(input, x, y)
    abc.each_with_index.map do |line, index|
      memo[index] ||= []
      memo[index] += line  
    end
    memo.push(abc)
  end
  memo

end

puts "ok"
