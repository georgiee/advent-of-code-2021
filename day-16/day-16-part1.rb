require 'benchmark'
require 'stringio'

file_content = File.read(File.join(__dir__, 'input.txt'))

class Decoder
  attr_accessor :versions
  TYPE_LITERAL_VALUE = 4
  TYPE_ID_15 = 0
  TYPE_ID_11 = 1
  
  def initialize(file_content)
    @values = []
    @versions = []
    @io = StringIO.new(unpack(file_content))
  end
  
  def unpack(file_content)
    file_content.chomp.chars.map{ '%04b' % _1.to_i(16) }.join
  end

  def read_header
    version = @io.read(3).to_i(2)
    @versions << version
    type_id = @io.read(3).to_i(2)

    [version, type_id]
  end
  
  def read_literal_value
    value = []
  
    while (group = @io.read(5))
      value << group[1..-1]
      break if group.start_with?("0")
    end
    
    value.join.to_i(2)
  end
  
  def process_operator
    length_type = read(1).to_i(2)
    
    if length_type == TYPE_ID_15
      package_length = read(15).to_i(2)
      start = @io.pos

      while @io.pos - start < package_length
        next_package
      end
    end

    if length_type == TYPE_ID_11
      package_count = read(11).to_i(2)
      values = package_count.times.collect { next_package }
    end
  end
  
  def read(c)
    @io.read(c)
  end
  
  def last_value
    @values.last
  end
  
  def decode
    next_package
  end
  
  def next_package
    version, type = read_header
    puts "version #{version}, type #{type}"
    
    if type == TYPE_LITERAL_VALUE
      @values << read_literal_value
      puts "value is #{last_value}"
    else
      process_operator
    end
  end
end

decoder = Decoder.new(file_content)

decoder.decode
result = decoder.versions.sum
puts "versions summed: #{result}"

puts input_str
