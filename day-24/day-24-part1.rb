require 'benchmark'
require 'stringio'
require "enumerator"
require 'set'

file_content = File.read(File.join(__dir__, 'input.txt'))
input = file_content.scan(/(inp|mul|add|mod|div|eql) (.)[ ]?(.*)?/)

factors = input.each_slice(18).map do |step|
  f1 = step[4][2].to_i #div z
  f2 = step[5][2].to_i #add x 10
  f3 = step[15][2].to_i # add y 13
  [f1, f2, f3]
end

def process(z, f1, f2, f3)
  if (z % 26 + f2) == value
    z.div(f1)
  else
    z.div(f1) * 26 + value + f3
  end
end

factors.each do |(f1, f2, f3)|
puts f1
end

#
# class Alu
#   attr_accessor :w, :x, :y, :z
#  
#   def initialize(instructions)
#     @instructions = instructions
#     @io = nil
#   end
#  
#   def run(io)
#     @io = io
#     @w = @x = @y = @z = 0
#     @instructions.each_slice(18).each_with_index do | subset, index |
#       #puts "#{index}: #{@w} #{@x} #{@y} #{@z}"
#
#       subset.each do |instruction|
#         send(instruction[0], *(instruction[1..-1]))
#       end
#     end
#    
#     @z.zero?
#   end
#  
#   def inp(w, _)
#     value = @io.next.to_i
#     send("#{w}=", value)
#   end
#  
#   def get_value(accessor)
#     return send(accessor) if Alu.method_defined?(accessor)
#     accessor.to_i
#   end
#
#   def mul(a,b)
#     result = send(a) * get_value(b)
#     send("#{a}=", result)
#   end
#  
#   def add(a, b)
#     result = send(a) + get_value(b)
#     send("#{a}=", result) 
#   end
#  
#   def div(a,b)
#     remainder = send(a).div(get_value(b))
#     send("#{a}=", remainder)
#   end
#    
#   def mod(a,b)
#     remainder = send(a).modulo(get_value(b))
#     send("#{a}=", remainder)
#   end
#  
#   def eql(a,b)
#     if send(a) == get_value(b)
#       send("#{a}=", 1)
#     else
#       send("#{a}=", 0)
#     end
#   end
# end
#
#
#
#
# class Alu2
#   attr_accessor :w, :x, :y, :z
#
#   def initialize(steps)
#     @steps = steps
#     @x = @y = @z = 0
#   end
#  
#   def run(io)
#     # puts "### run alu2"
#     @io = io
#     @x = @y = @z = 0
#     puts "processing with #{@steps.join(',')}"
#     @steps.each_with_index do |(f1, f2, f3)|
#       @z = process(@io.next, @z, f1, f2, f3)
#     end
#   end
#  
#   def single_process(value)
#     @x = @y = @z = 0
#   end
#  
#   def process(value,z, f1, f2, f3)
#     puts "#{f1}, #{f2}, #{f3}"
#     # chunk by chunk reduced
#     if (z % 26 + f2) == value
#       z.div(f1)
#     else
#       z.div(f1) * 26 + value + f3
#     end
#   end
#  
#   def good?
#     @z.zero?
#   end
# end
#
# steps_factors = input.each_slice(18).map do |step|
#   f1 = step[4][2].to_i #div z
#   f2 = step[5][2].to_i #add x 10
#   f3 = step[15][2].to_i # add y 13
#   [f1, f2, f3]
# end
#
#
# a2 = Alu2.new(steps_factors)
# a2.run("13579246899990".chars.map(&:to_i).each)
#
# if a2.z != 175155198
#   throw 'algorithm changed'
# end
#
# puts a2.z # 175155198
#
# #res = a2.process(1, 1, 15,13)
#
#
# p a2.good?
# # 
# # p 'ok'
#
# # a1 = Alu.new(input)
# # a1.run("13579246899999".chars.map(&:to_i).each)
#
# # serial = 14.times.collect{9}.join.to_i
# # counter = 0
# #
# # loop do
# #   counter += 1
# #   serial_enum = serial.to_s.chars.map(&:to_i).each
# #   a2.run(serial_enum)
# #
# #   if counter.modulo(1000).zero?
# #     p serial
# #   end
# #
# #   if a2.good?
# #     puts "found #{serial}"
# #     break
# #   end
# #
# #   serial -= 1
# # end
#
#
# #p 'done'
