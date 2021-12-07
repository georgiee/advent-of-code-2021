require 'benchmark'

path = File.join(__dir__, 'input.txt')
input = File.read(path).split(',').map(&:to_i)



result = input.compact.uniq.map do |position|
  fuel = input.inject(0) do |memo, value|
    memo + (value - position).abs
  end

  [position, fuel]
end


puts result.min_by { _1[1] }[1]
