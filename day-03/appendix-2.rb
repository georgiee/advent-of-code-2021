# I wanted to calculate only with bit operatitons
# here part 1

EXAMPLE_DATA = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]
# just needs to be big enough
MAX_BIT_LENGTH = 5

path = File.join(__dir__, 'input.txt')
input = File.read(path).split
input = EXAMPLE_DATA


# input = input.map{_1.to_i(2)}
# rr = input.map  do |binary|
#   mask = (1 << 4)
#   # 3. compare the number with the mask through a bitwise and (&)
#   # this will yield an isolated 1 or 0 at the given index and drop any other bits
#   # given 0b10111 with a mask of 0b100 (1 << 2) we get back 0b100
#   # by shifting that bit to the first position we get the 1 or 0
#   # 0b100 >> 2 
#   (binary & mask) >> 4 == 1
# end
# puts rr
# get the bit in a binary numbers (right to left)
def get_bit_at(binary_number, index)
  # 1. convert a binary string into an integer
  number = binary_number.to_i(2)
  # 2. create a bit mask for the given index of the bit
  # 1 << 1 creates the binary number 0b1 (which you can see as 0b0001 or whatever bit size you have)
  # 1 << 3 creates the binary number 0b1000
  # 1 << 5 creates the binary number 0b100000
  mask = (1 << index)
  # 3. compare the number with the mask through a bitwise and (&)
  # this will yield an isolated 1 or 0 at the given index and drop any other bits
  # given 0b10111 with a mask of 0b100 (1 << 2) we get back 0b100
  # by shifting that bit to the first position we get the 1 or 0
  # 0b100 >> 2 
  (number & mask) >> index
end

def find_most_common_bits(binaries)
  MAX_BIT_LENGTH.times.collect do |bit|
    # returns an array of bits of the specified bit index
    # we want to start at the left side to count the index backwards
    bit_plane = binaries.map { get_bit_at(_1, MAX_BIT_LENGTH - 1 - bit) }
    # tally gives us a map of occurences
    # and max_by returns key (here 0 or 1) with the occurences as the second element
    most_common_bit = *bit_plane.tally.max_by{|k,v| v}
    most_common_bit[0]
  end.join
end

def find_most_common_bit(binaries, bit)
  plane = get_bit_plane(binaries, bit)
  most_common_bit = *plane.tally.max_by{|k,v| v}
  most_common_bit[0]
end

def get_bit_plane(binaries, bit)
  binaries.map { get_bit_at(_1, MAX_BIT_LENGTH - 1 - bit) }
end

def find_least_common_bits(binaries)
  MAX_BIT_LENGTH.times.collect do |bit|
    # returns an array of bits of the specified bit index
    # we want to start at the left side to count the index backwards
    bit_plane = binaries.map { get_bit_at(_1, MAX_BIT_LENGTH - 1 - bit) }
    # tally gives us a map of occurences
    # and max_by returns key (here 0 or 1) with the occurences as the second element
    most_common_bit = *bit_plane.tally.min_by{|k,v| v}
    most_common_bit[0]
  end
end

bit_index = 0
while input.size > 1
  most_common_bit = find_most_common_bit(input, bit_index)
  puts most_common_bit
  input.filter! do |binary|
    current_bit = get_bit_at(binary, MAX_BIT_LENGTH - 1 - bit_index)
    current_bit == most_common_bit
  end
  bit_index += 1
  puts gamma
end

puts "done"

#gamma = find_most_common_bits(input).join.to_i(2)
#epsilon = find_least_common_bits(input).join.to_i(2)

# bitwise not (~) in ruby creates negative numbers so I can't use ~gamma
# 1 << BIT_LENGTH creates 0b100000 
# while I need 0b11111 (to flip all bits) which is exactly 1 numbers less (hence  `- 1`)
#epsilon = gamma ^ ((1 << 5) - 1)

#power = gamma * epsilon

#puts "power is #{power}"
