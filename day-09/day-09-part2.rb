require 'benchmark'

path = File.join(__dir__, 'input.txt')
lines = *File.readlines(path).to_a
input = lines.map {_1.chomp.split('').map(&:to_i)}


class Grid
  NEIGHBOURS = [[-1, 0],  [0, 1], [1, 0], [0, -1],]

  def initialize(coords)
    @coords = coords
    @width = @coords.first.size
    @height = @coords.size
  end

  def [](x,y)
    @coords[y][x]
  end

  def lowpoints
    Enumerator.new do |yielder|
      (0..(@width - 1)).each do |x|
        (0..(@height - 1)).each do |y|
          if lowpoint?(x, y)
            yielder << [x, y]
          end
        end
      end
    end
  end

  def lowpoint?(x, y)
    neighbours = find_neighbour_values(x, y)
    neighbours.all? { _1 > self[x, y] }
  end

  def find_neighbours(x, y)
    NEIGHBOURS.inject([]) do |memo, value|
      newx = x + value[0]
      newy = y + value[1]

      x_good = newx >= 0 && newx < @width
      y_good = newy >= 0 && newy < @height

      memo << [newx, newy] if x_good && y_good

      memo
    end
  end

  def find_neighbour_values(x, y)
    n = find_neighbours(x, y)
    n.map{ self[_1[0], _1[1]] }
  end

  def value(point)
    self[point[0], point[1]]
  end
  
  def basin(center)
    x = center[0]
    y = center[1]
    height = value(center)
    heights_found = [height]
    
    while height != 9 && x + 1 < @height do
      x += 1
      height = value([x, y])
      heights_found << height if height < 9
    end

    heights_found
  end
  def basins
    lowpoints.inject({}) do |memo, value|
      memo[value] = flow(value)
      memo
    end
  end
  
  def flow(center, visited = [], collect = [])
    visited << center
    n = find_neighbours(center[0], center[1])
    collect << center
    #puts "flow start here #{center}"

    n.each do |coord|
      if self.value(coord) != 9
        been = visited.include?(coord)
        
        if !been
          #puts "collect neighbour #{coord} #{self.value(coord)}"
          #puts "flow next #{center} -> #{coord}"
          collect += flow(coord, visited)
        end
      end
    end
    
    collect
  end
end

# coordinates = input.flatten.each_with_index do | value, index|
#   x = index%width
#   y = (index - x) / width
#   neighbours = find_neighbours(x, y)
#
#   puts "#{x} #{y}"
# end

grid = Grid.new(input)
lowpoints = grid.lowpoints

result = grid.basins.values.map{ _1.length }.sort.reverse[0..2].inject(&:*)
puts result
