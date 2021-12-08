require 'benchmark'

path = File.join(__dir__, 'input.txt')
lines = *File.readlines(path).to_a
input = lines.map { |line| line.split(' | ').map { _1.split(' ') }}

output = input.map {_1[1]}
signal_patterns = input.map {_1[0]}

# a-h corresponds to the mapping from 
# https://en.wikipedia.org/wiki/Seven-segment_display
SEVEN_SEGMENT_MAP = {
  1 => %i[b c],
  2 => %i[a b d e g],
  3 => %i[a b c d g],
  4 => %i[b c f g],
  5 => %i[b c d f g],
  6 => %i[a c d e f g],
  7 => %i[a b c],
  8 => %i[a b c d e f g],
  9 => %i[a b c d f g]
}.freeze

first_signal = signal_patterns.first.map { _1.chars}

def get_digit(signal, digit)
  signal.detect{ _1.length === SEVEN_SEGMENT_MAP[digit].length}
end

def get_map(digit)
  SEVEN_SEGMENT_MAP[digit]
end

hash = {}

def get_mapping1(d1, d2, signal)
  a = get_digit(signal, d1)
  b = get_digit(signal, d2)
  a1 = get_map(d1)
  b1 = get_map(d2)
  
  [(a1 - b1).first, (a - b).first]
end

result = get_mapping1(7, 1, first_signal)


puts "ok"

# EASY_DIGITS_SEGMENTS_MAP = {
#   1 => [b=>1, 2],
#   4 => 4,
#   7 => 3,
#   8 => 7
# }.freeze
#
# SEVEN_SEGMENT_MAP_EASY = SEVEN_SEGMENT_MAP.select {|k,v| [1, 4, 7, 8].include?(k)}
# #easy = (SEVEN_SEGMENT_MAP[1] + SEVEN_SEGMENT_MAP[4] + SEVEN_SEGMENT_MAP[7] + SEVEN_SEGMENT_MAP[8]).uniq
#
# output = input.map {_1[1]}
# signal_patterns = input.map {_1[0]}
#
#
#
# signals = signal_patterns[0]
# hash = Hash.new
#
# result = signals.inject([]) do |memo, signal|
#   found = SEVEN_SEGMENT_MAP_EASY.values.detect{_1.length == signal.length}
#   next memo if found.nil?
#
#   memo << [signal.split(""), found]
# end
# # SEVEN_SEGMENT_MAP_EASY.each_pair do |k, v|
# #   puts k
# # end
#
# result = signals.inject([]) do |memo, signal|
#   found = SEVEN_SEGMENT_MAP_EASY.values.detect{_1.length == signal.length}
#   next memo if found.nil?
#
#   memo << [signal.split(""), found]
# end
#
#
#
# combinations = signals.permutation(2).to_a.map do |a, b|
#   items = [a,b].map(&:chars)
# 
# end
#
# combs = SEVEN_SEGMENT_MAP.values.permutation(2).to_a.inject([]) do |memo, items|
#   a, b = *items
#   next memo if (a & b).size != 1
#   memo << [a & b, a, b]
# end
# puts "ok"
