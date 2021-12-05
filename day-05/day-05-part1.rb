require 'ostruct'

path = File.join(__dir__, 'input.txt')
input = File.read(path)

class Vector
  attr_accessor :p1, :p2
  
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end
  
  # get all coordinate covered by this vector (diagonals are empty)
  def spread
    return [] if diagonal?
    dx = @p2.x - @p1.x
    dirx = dx > 1 ? 1 : -1
    dy = @p2.y - @p1.y
    diry = dy > 1 ? 1 : -1

    return (dx.abs + 1).times.collect {[@p1.x + dirx * _1, @p1.y]} if @p1.y == @p2.y
    return (dy.abs + 1).times.collect {[@p1.x, @p1.y + diry * _1]} if @p1.x == @p2.x
  end
  
  def diagonal?
    !(@p1.x == @p2.x || @p1.y == @p2.y)
  end
end

COORD_FORMAT = /((\d+),(\d+)) -> ((\d+),(\d+))/.freeze
coords = input.split("\n").map { _1.match(COORD_FORMAT) }.map {
  Vector.new(
    OpenStruct.new(x: _1[2].to_i, y: _1[3].to_i),
    OpenStruct.new(x: _1[5].to_i, y: _1[6].to_i)
  )
}


# fill the grad
coverage = coords.map(&:spread).compact.flatten(1).tally
result = coverage.values.count{ _1 >=2 }
puts result


#
# class Vector
#   def initialize(p1, p2)
#     @p1 = p1
#     @p2 = p2
#   end
#
#   def dy
#     @p2.y - @p1.y
#   end
#
#   def dx
#     @p2.x - @p1.x
#   end
#
#   def c
#     dy * @p1.x + dx * @p1.y
#   end
#
#   def intersect?(other)
#     denominator = dy * other.dx - other.dy * dx
#     return nil if denominator.zero?
#
#     x = (other.dx * c - dx * other.c) / denominator
#     y = (dy * other.c - other.dy * c) / denominator
#
#     OpenStruct.new(x: x, y: y)
#   end
# end
#
