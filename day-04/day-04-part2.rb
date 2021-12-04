path = File.join(__dir__, 'input.txt')
input = File.read(path)


class Board
  attr_accessor :rows, :columns
  def initialize(numbers, index)
    @index = index
    @rows = numbers
    @columns = numbers.transpose
  end

  def wins?(draw)
    @rows.any? { |row| (row - draw).empty? } || @columns.any? { |columns| (columns - draw).empty? }
  end

  def unmarked(draws)
    @rows.flatten - draws
  end
end


draws = input.lines[0].split(',').map(&:to_i)
boards = (input.lines[1..-1].to_a).each_with_index.inject([]) do |memo, value|
  line, index = *value
  line.chomp!

  if index%6 == 0
    # add a new board and skip the empty line
    memo.push([])
  else
    memo.last << line.scan(/\d+/).map(&:to_i)
  end

  memo
end.each_with_index.map { Board.new(_1, _2)}

# part 2
winner_boards =[]
draws.size.times.each do |round|
  numbers = draws[0..round].to_a
  current_number = numbers[round]

  winners = boards.select {|board| board.wins?(numbers)}
  if winners.size > 0
    winners.each { winner_boards  << boards.delete(_1) }
  end

  if boards.empty?
    unmarked_sum = winner_boards.last.unmarked(numbers).sum
    result = unmarked_sum * current_number
    puts result
    break
  end
end
