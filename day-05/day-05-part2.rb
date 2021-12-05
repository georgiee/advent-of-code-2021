require 'ostruct'

path = File.join(__dir__, 'input.txt')
input = File.read(path)

class Vector
  attr_accessor :p1, :p2

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end

  def dy
    @p2.y - @p1.y
  end

  def dx
    @p2.x - @p1.x
  end
  
  def dir_y
    if dy.zero?
      0
    else
      dy.positive? ? 1 : -1
    end
  end
  
  def dir_x
    if dx.zero?
      0
    else
      dx.positive? ? 1 : -1
    end
  end

  def diagonal?
    !(@p1.x == @p2.x || @p1.y == @p2.y)
  end
  
  # get all coordinate covered by this vector (diagonals are empty)
  def spread
    items = []
    
    ([dx.abs, dy.abs].max + 1).times do |index|
      items << [@p1.x + dir_x * index, @p1.y + dir_y * index]
    end

    items
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

