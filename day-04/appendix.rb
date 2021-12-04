# much more elegant
# 1. Source from https://tzarnal.github.io/Opal/#XQAAAQBLBQAAAAAAAAAxmwhIY/U8uCvV3MBTRcLmg+3/UZp6nzdBmHqJnigx6N8zdlE0Prd9rod6fg6O45LH2CEcTIce6Q7nzm9yIQ6Dg8/gJ45Eevtmo9v2hPx2fDjUxXAADuAr8DCXLyxRSSni9mA3GQXzpaj38zpREqz5jAdOQHXh+j02p2yYlfHhMgkweg7uZxALALEI4kRnod64/N5b/pOApEau6Plvx99C72UNH3aazlUtQGzUqUQa7Ulfm1oFpiRHQ1Bv5sROoqVYd95guiNh5/zIzE9EUqbVs+hUhFkLkgyytHBK2AZukUY6y7p7oRcSttM9Y2qYL8BzyFw9Y+k2qYoboQlHZocHer/7zqYR1UD4tDy96G2Ou/zXt9C+wLzSvp7LRBg7qM/6p4DuWfoOOoqTjFgYcS3SLHizrVLABkZMnBedFsZ9nO8DXo+xGNPsxEyqFzdcvsJ7txOlvxFkLhNPgzMrfoepbNq16Ynwbn0m+fDs0mt5z1oqLHvBb9CDy5tlWG0wPL4ZdXenK2mTgiY1Z/b+jGTN65E8+IL73GrEr9LiEvpAzTga1xfaUhWS1TpDjuFp80mcY27a7NvRmSZ0n8bG5Uo5UVtX5lxg7bkCQF5iAKXLRwulzfDePnTRxE0Uw5VGWetzy8tKvxlv14g91kX+z7juIWbPBulOEGaWntZbhAz/86QwEw==
# Via https://www.reddit.com/r/adventofcode/comments/r8i1lq/2021_day_4_solutions/hn64f25/


class Bingo
  attr_reader :dobbs, :boards

  def initialize(input)
    dobbs, *boards = input.split("\n" * 2)
    @dobbs = dobbs.split(',').map(&:to_i)
    @boards = boards.map{|_board| Board.new(_board)}
  end

  def first_winner_score
    dobbs.each do |dobb|
      boards.each do |board|
        board.dobb(dobb)
        return board.score if board.winner?
      end
    end
  end

  def last_winner_score
    dobbs.each do |dobb|
      boards.each do |board|
        board.dobb(dobb)
      end
      if boards.one? && boards.last.winner?
        return boards.last.score
      end
      boards.delete_if(&:winner?)
    end
  end

  class Board
    attr_reader :rows, :last_dobb
    def initialize(board)
      @rows = board.split("\n")
                   .map {|row| row.split.map(&:to_i)}
      @last_dobb
    end

    def dobb(number)
      @last_dobb = number
      rows.map! do |row|
        row.map! do |val|
          number == val ? nil : val
        end
      end
    end

    def columns
      rows.transpose
    end

    def winner?
      rows.any? {|row| row.all?(&:nil?)} ||
        columns.any? {|column| column.all?(&:nil?)}
    end

    def score
      rows.flatten.compact.sum * last_dobb
    end
  end
end

input = File.read('input.txt')
puts Bingo.new(input).first_winner_score
puts Bingo.new(input).last_winner_score
