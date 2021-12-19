require 'benchmark'
require 'stringio'
require "enumerator"

file_content = File.read(File.join(__dir__, 'input.txt'))

input = file_content.split(/\-{3} scanner \d+ \-{3}\n/).drop(1)
input = input.map{ | row | row.split(/\n/).map{ |numbers| numbers.split(',').map(&:to_i)} }


class Scanner
  attr_accessor :coordinates
  @@ups = 3.times.collect{[0, 1, 2].rotate(_1)}
  @@facings = [1, -1].repeated_permutation(3).to_a
  @@orientations = @@facings.product(@@ups)


  def initialize(relative_coordinates)
    @coordinates = relative_coordinates
  end
  
  def center_at(center)
    # aa = @coordinates.map{ _1.zip(center).map { |a, b| a - b } }
    result = @coordinates.map { |item|  item.zip(center).map do |(pos, d)|
      pos  - d
    end
    }
    result
  end
  
  
  def variant(facing, up)
    # change face
    ok = @coordinates.map { _1.zip(facing).map { |x, y| y * x } }
    # change up
    ok = ok.map{ [ _1[up[0]], _1[up[1]], _1[up[2]] ] }
      
    ok
  end

  def get_variants
    @@orientations.map do |(facing, up)|
      variant(facing, up)
    end
  end
  
  def get_matches(other)
    @@orientations.map do |(facing, up)|
      other.coordinates & variant(facing, up)
    end
  end
  
  def relative_to(other)
    Scanner.new(@coordinates.zip(other.coordinates).map{ |a,b| a.zip(b).map{ _2}})
  end
end

scanners = input.map{Scanner.new(_1)}
a = scanners.first
b = scanners[1]


# res = b.coordinates.map { |item| item.zip(a.coordinates).map {_2 - _1} }
#b1 = scanners[1].get_variants.map { |variants| variants & }

#
# y = b.center_at([68,-1246,-43])
#
# b1 = b.relative_to(scanners.first)
# m = b1.get_matches(scanners.first)
# puts "ok"
# #
# # x = a - b
# # dd = a.get_matches(b)

puts "okay"
