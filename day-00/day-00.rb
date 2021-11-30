# frozen_string_literal: true

# just to make sure that everything works with ruby and that I'm ready for day one

path = File.join(__dir__, 'input.txt')
input = File.read(path)

puts 'okay works'
puts (input.split).map(&:to_i)
