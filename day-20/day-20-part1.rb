require 'benchmark'
require 'stringio'
require "enumerator"

file_content = File.read(File.join(__dir__, 'input.txt'))

algorithm, input_image = *(file_content.split(/\n\n/).map {_1.chomp})
input_image = input_image.split(/\n/)

initial_pixels = input_image.each_with_index.inject({}) do |memo, (row, y)|
  row.split("").each_with_index do |value, x|
    memo[[x,y]] = value
  end
  memo
end

class Image
  attr_accessor :size
  
  CONVOLVE_NEIGHBORS = [[-1, -1], [0, -1], [1, -1], [-1, 0], [0, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
  DARK_PIXEL = '.'
  LIT_PIXEL = '#'
  PIXEL_MAP = { DARK_PIXEL => 0, LIT_PIXEL => 1 }
  
  def initialize(pixels, algorithm, iteration = 0)
    @lookup = algorithm
    @iteration = iteration
    @pixels = Hash.new(@iteration%2 == 1 ? LIT_PIXEL : DARK_PIXEL).merge(pixels)
    inherit_size = calculate_size(@pixels)
   
    dd = if size
      (size - inherit_size)/2
      else
      0
   end
    
    @size = size || inherit_size 
    @pixels.transform_keys!{|(x,y)| [x + dd, y + dd]}
  end
  
  def calculate_size(pixels)
    pixels.keys.map{_1[0]}.max + 1
  end
  
  
  def evolve(grow=1)
    new_size = @size + grow * 2 # grow by 1x1
    new_pixels = {}
    new_size.times do |y|
      new_size.times do |x|
        new_pixels[[x,y]] = convolve(x - grow, y - grow) 
      end
    end
    
    puts "new_size #{new_size} #{@size} are lit"
    
    Image.new(new_pixels, @lookup, @iteration + 1)
  end

  def print(add_size = 0)
    
    res = (@size + add_size*2).times.inject([]) do |memo, y|
     (@size + add_size*2).times do |x|
        memo[y] ||= []
        memo[y][x] = self[x - add_size, y - add_size]

        memo
      end

      memo
    end
    res.each{puts _1.join}
    puts "#{@size}x#{@size} (#{count_lits})"
  end
  
  def convolve(x,y)
    values = CONVOLVE_NEIGHBORS.map{|dx, dy| [x+ dx, y + dy]}.map do |coord|
      @pixels[coord]
    end
    mapped = values.map{PIXEL_MAP[_1]}.join.to_i(2)
    @lookup[mapped]
  end

  
  def [](x,y)
    @pixels[[x,y]]
  end
  
  def count_lits
    @pixels.values.count {_1 == LIT_PIXEL }
  end
end

image = Image.new(initial_pixels, algorithm)
puts "\n\n\nNEXT\n\n\n"

image.print()
2.times do |index|
  puts "\nrun ##{index}"
  image = image.evolve(1)
  image.print()
end

