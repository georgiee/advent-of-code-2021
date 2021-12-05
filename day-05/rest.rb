# wanted to use linear alegbra and dirtched it as it's not helping with parallel lines, covered grid coordinates and such 😬
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
