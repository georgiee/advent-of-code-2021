require 'benchmark'
require 'stringio'
require "enumerator"

file_content = File.read(File.join(__dir__, 'input.txt'))
arrays = file_content.each_line.map{eval(_1.chomp)}




input = "[[[[[9,8],1],2],3],4]"

def explode2(input)level = 0
  collect = []
  
  found = nil
  left_digit = nil
  right_digit = nil

  indices =[]
  input.chars.each_with_index do |char, index|
    if char == '['
      level += 1
    end
  
    if collect.empty? && char.match?(/[[:digit:]]/)
      left_digit = char.to_i
    end

    if level == 4 && char == '['
      indices << index
    end
    
    if level == 4 && char == ']'
      indices << index
    end
    
    if level > 4 && found.nil?
      collect << char
  
      if char == ']'
        found = eval(collect.join)
      end
    end
    
    if right_digit.nil? && found && char.match?(/[[:digit:]]/)
      right_digit = char.to_i
    end
  end
  [left_digit, found, right_digit, indices]
end

result = explode2(input)
puts

# def explode(value)
#   folks = value.flatten(3)
#   first_array = folks.select{_1.class == Array}.first
#  
#   index = folks.index(first_array)
#  
#   a, b = first_array
#   left = [0, index - 1].max
#   right = [folks.size - 1, index + 1].min
#
#
#   folks[index] = 0
#  
#   if left != index
#     folks[left] += a
#   end
#  
#   if right != index
#     folks[right] += b
#   end
#
#   folks
# end
#
# res = explode([[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]])
#
# def split(values)
#   values.inject([]) do |memo, item|
#     if item.is_a?(Array)
#       memo << split(item)
#     else
#       if item >= 10
#         memo << [ (item/2.to_f).floor,  (item/2.to_f).ceil]
#         # actual split
#       else
#         memo << item
#       end
#     end
#   end
# end
#
# abc = split([[[[0,7],4],[15,[0,13]]],[1,1]])
# # x = walk2(4,[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]])

puts arrays

