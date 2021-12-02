require 'ostruct'

path = File.join(__dir__, 'input.txt')
input = File.read(path)

COMMAND_FORMAT = /(\D*) (\d+)/.freeze

submarine = OpenStruct.new(position: 0, depth: 0, aim: 0)

input.each_line.map do |line|
  _, command, amount = *line.match(COMMAND_FORMAT)
  amount = amount.to_i

  case command
  when 'forward'
    submarine.position += amount
    submarine.depth += submarine.aim * amount
  when 'down', 'up'
    op = :+ if command == 'down'
    op = :- if command == 'up'
    submarine.aim = submarine.aim.send(op, amount)
  else
    throw "unknown command #{command}"
  end
end

puts submarine.position * submarine.depth

