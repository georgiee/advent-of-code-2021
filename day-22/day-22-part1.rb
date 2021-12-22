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
  
  def within?
    range_within?(rx, -50..50) &&
    range_within?(ry, -50..50) &&
    range_within?(rz, -50..50)
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
end



class CubeRange
  attr_accessor :rx, :ry, :rz
  
  def initialize
    @rx = @ry = @rz = nil
  end

  def on(range)
    @rx = range.rx if @rx.nil?
    @ry = range.ry if @ry.nil?
    @rz = range.rz if @rz.nil?

    @rx = combine(@rx, range.rx)
    @ry = combine(@ry, range.ry)
    @rz = combine(@ry, range.rz)
  end

  def off(exclude)
    rr = [@rx.first, exclude.rx.first].max
    rr2 = [@rx.last, exclude.rx.last].min
    puts
  end
end

ON_CUBE = CubeRange.new

result = input.inject(Set.new) do |memo, (state, rx, ry, rz)|
  cube = Cube.new(rx: rx, ry: ry, rz: rz)
  
  next memo unless cube.within?
  
  puts "add size #{cube.size}"
  # 
  if state == "on"
    memo += cube.to_coordinates
  end

  if state == "off"
    memo -= cube.to_coordinates
  end

  memo
end

#
# res = result[1].inject([]) do |memo, off_range|
#   items = result[0].map do |on_range|
#     [off_range.last, on_range.first].max..[off_range.first, on_range.last].max
#   end
#   memo.push(*items)
#   memo
# end


puts "result is #{result.size}"
puts "ok"
