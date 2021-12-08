require 'benchmark'

path = File.join(__dir__, 'input.txt')
lines = *File.readlines(path).to_a
input = lines.map { |line| line.split(' | ').map { _1.split(' ') }}

EASY_DIGITS_SEGMENTS_MAP = {
  ONE: 2,
  FOUR: 4,
  SEVEN: 3,
  EIGHT: 7
}.freeze

input_easy = input.map{_1[1]}
input_full = input.map{_1.flatten}

result = input_easy.map do |line|
  line.group_by { _1.length}.delete_if{!EASY_DIGITS_SEGMENTS_MAP.values.include?(_1)}.transform_keys{EASY_DIGITS_SEGMENTS_MAP.key(_1)}
end

items =  result.map { _1.values }.flatten

puts items.size
