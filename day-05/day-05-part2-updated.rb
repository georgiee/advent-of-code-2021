require 'ostruct'

path = File.join(__dir__, 'input.txt')
input = File.read(path)

class Vector
  attr_accessor :p1, :p2

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end
  
  def diagonal?
    !(@p1.x == @p2.x || @p1.y == @p2.y)
  end
  
  # get all coordinate covered by this vector (diagonals are empty)
  def spread
    spreader = Enumerator.new do |yielder|
      x = @p1.x
      y = @p1.y
      dx = @p2.x <=> @p1.x
      dy = @p2.y <=> @p1.y

      loop do
        yielder << [x, y]

        x += dx
        y += dy
      end
    end

    spreader.take_while { _1 != [@p2.x, @p2.y] } + [[@p2.x, @p2.y]]
  end
end

COORD_FORMAT = /((\d+),(\d+)) -> ((\d+),(\d+))/.freeze

coords = input.split("\n").map { _1.match(COORD_FORMAT) }.map {
  Vector.new(
    OpenStruct.new(x: _1[2].to_i, y: _1[3].to_i),
    OpenStruct.new(x: _1[5].to_i, y: _1[6].to_i)
  )
}

# fill the grid and count the duplicate coordinates (intersections)
coverage = coords.map(&:spread).compact.flatten(1).tally
result = coverage.values.count{ _1 >= 2 }

puts result

