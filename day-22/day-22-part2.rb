require 'benchmark'
require 'stringio'
require "enumerator"
require 'set'

file_content = File.read(File.join(__dir__, 'input.txt'))
input = file_content.scan(/(on|off) x=(.*),y=(.*),z=(.*)/)
input = input.map{[_1, eval(_2), eval(_3), eval(_4)] }

def combine(a, b)
  ([a.first, b.first].min..[a.last, b.last].max)
end

def range_within?(range, other)
  other.first <= range.last && range.first <=other.last
end

def invert_hash(hash)
  hash.each_with_object({}){ |(k, v), o| (o[v]||=[] ) << k }
end

def clamp_range(range, limit)
  [range.min, limit.min].max..[range.max, limit.max].min
end

PART1_LIMIT = -50..50

class Cube
  attr_accessor :rx, :ry, :rz

  def initialize(rx: 0..0, ry:0..0, rz:0..0)
    @rx, @ry, @rz = clamp_range(rx, PART1_LIMIT), clamp_range(ry, PART1_LIMIT), clamp_range(rz, PART1_LIMIT)
    puts
  end

  def within?(other)
    range_within?(rx, other.rx) &&
      range_within?(ry, other.rx) &&
      range_within?(rz, other.rx)
  end

  def size
    rx.size * ry.size * rz.size
  end

  def to_coordinates
    coordinates = []

    rz.step(1) do |x|
      ry.step(1) do |y|
        rx.step(1) do |z|
          coordinates << [x, y, z]
        end
      end
    end

    coordinates
  end
  
  def xMin
    rx.first
  end
  
  def xMax
    rx.last
  end
  
  def yMin
    ry.first
  end
  
  def yMax
    ry.last
  end
  
  def zMin
    rz.first
  end
  
  def zMax
    rz.last
  end
  def intersect(other)
    x = [other.xMax - xMin, 0].max
    y = [other.yMax - yMin, 0].max
    z = [other.zMax - zMin, 0].max
    
    puts
  end
end

result = input.inject([[], []]) do |memo, (state, rx, ry, rz)|
  memo[0] << Cube.new(rx: rx, ry: ry, rz: rz) if state == "on"
  memo[1] << Cube.new(rx: rx, ry: ry, rz: rz) if state == "off"
  memo
end

a = Cube.new(rx: 1..10, ry: 1..10,rz: 1..10)
b = Cube.new(rx: 5..10, ry: 5..10,rz: 5..10)

c = a.intersect(b)

last = result[0].reject do |on|
  result[1].any? { on.within?(_1)}
end



#
# res = result[1].inject([]) do |memo, off_range|
#   items = result[0].map do |on_range|
#     [off_range.last, on_range.first].max..[off_range.first, on_range.last].max
#   end
#   memo.push(*items)
#   memo
# end


puts "ok"
