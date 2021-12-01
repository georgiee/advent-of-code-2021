path = File.join(__dir__, 'input.txt')
input = File.read(path)

measurements = input.split.map(&:to_i)
measurement_pairs = measurements.each_cons(2)

result = measurement_pairs.inject(0) do |memo, elements|
  a, b = elements

  if b > a
    memo + 1
  else
    memo
  end
end

puts result
