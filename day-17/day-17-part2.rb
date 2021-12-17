require 'benchmark'
require 'stringio'
require "enumerator"
file_content = File.read(File.join(__dir__, 'input.txt'))


Probe = Struct.new(:x, :y, :vx, :vy)


def within_area?((sx, sy, ex, ey), (x, y) )
  x >= sx && x <= ex && y >= sy && y <= ey
end

def beyond_area?((sx, sy, ex, ey), (x, y) )
  x > ex || y < sy
end


def create(vx:, vy:)
  max_y = 0
  Enumerator.new do |yielder|
    probe = Probe.new(0, 0, vx, vy)
    loop do
      probe.x += probe.vx
      probe.y += probe.vy
      probe.vx += -1 * (probe.vx <=> 0)
      probe.vy += -1
      max_y = [probe.y, max_y].max

      yielder << [[probe.x, probe.y], max_y]
    end
  end
end



class GridPrinter
  def initialize
    @grid = Hash.new('.')
  end

  def add((x,y))
    puts x,y
    @grid[[x, y]] = '#'
  end

  def create_area(sx, sy, w, h, symbol = 'T')
    w.times do |y|
      h.times do |x|
        @grid[[sx + x, sy + y]] = "#{symbol}"
      end
    end
  end

  def width
    @grid.keys.map{_1[0]}.max + 1
  end

  def height
    @grid.keys.map{_1[1]}.max + 1
  end

  def print
    height.times.inject([]) do |memo, y|
      width.times do |x|
        memo[y] ||= []
        memo[y][x] = @grid[[x, y]]

        memo
      end

      memo
    end.each{puts _1.join}
  end
end



def find

end

printer = GridPrinter.new
printer.create_area(20, 5, 5, 5, 'T')



def find_hit(vx, vy, target_area)
  probe_trajectory = create(vx: vx, vy: vy)
  last_within = nil

  while (trajectory = probe_trajectory.next) do
    position, max_y = trajectory

    within = within_area?(target_area, position)
    beyond = beyond_area?(target_area, position)

    if within
      return [position, [vx, vy], max_y]
    end

    if beyond
      return nil
    end
  end
end

target_area = [60, -171, 94, -136]
# target_area = [20, -10, 30, -5]

# brute forced by manual tinkering
# 1. for x I used velocities that make sense (everything that does not overshoot on the first step)
# 2. for y I used the lower bounds as the minimum vy and then probed
range_x = (0..94)
range_y = (-171..170) # guessed

combinations = range_x.to_a.product(range_y.to_a)

# brute force every combination
result = combinations.inject([]) do |memo, (vx, vy)|
  if hit = find_hit(vx, vy, target_area)
    memo << hit[1]
  end
  
  memo
end

puts "found #{result.size}"

# result.each {puts "#{_1}"}





