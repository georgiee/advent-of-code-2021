path = File.join(__dir__, 'input.txt')
input = File.read(path)

COMMAND_FORMAT = /(\D*) (\d+)/.freeze

position = 0
depth = 0


input.each_line.map do |line|
  _, command, amount =  *line.match(COMMAND_FORMAT)
  amount = amount.to_i
  
  
  if command == 'forward'
    position += amount
  else
    op = :+ if command == 'down'
    op = :- if command == 'up'

    depth = depth.send(op, amount)
   end
    
end
puts position * depth

