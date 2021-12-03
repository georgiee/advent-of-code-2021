path = File.join(__dir__, 'input.txt')
input = File.read(path)

transposed = input.split.map {|binary| binary.split("")}.transpose
# result.max_by { _1.count("1") > _2.count("0") }
gamma = transposed.map do |number|
  number.count("1") > number.count("0") ? "1" : "0"
end

gamma = gamma.join.to_i(2)
epsilon = gamma ^ 0xfff

puts gamma * epsilon
