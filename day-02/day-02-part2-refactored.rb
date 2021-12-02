path = File.join(__dir__, 'input.txt')
input = File.read(path)

COMMAND_FORMAT = /(\D*) (\d+)/.freeze

# refactored version to make more use of the send command I tried out before with operator
# Idea: I have a class that can directly handle the commands I send.
class Submarine
  def initialize
    @position = 0
    @depth = 0
    @aim = 0
  end

  def forward(amount)
    @position += amount
    @depth += @aim * amount
  end

  def down(amount)
    @aim += amount
  end

  def up(amount)
    @aim -= amount
  end
  
  def print
    puts @position * @depth
  end
end

submarine = Submarine.new

input.each_line.map do |line|
  _, command, amount = *line.match(COMMAND_FORMAT)
  amount = amount.to_i
  submarine.send(command, amount)
end

submarine.print
