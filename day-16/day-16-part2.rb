require 'benchmark'
require 'stringio'

file_content = File.read(File.join(__dir__, 'input.txt'))

class Decoder
  attr_accessor :versions

  def initialize(file_content)
    @values = []
    @version_counter = 0 # from part 1
    @io = StringIO.new(unpack(file_content))
  end

  def unpack(file_content)
    file_content.chomp.chars.map{ '%04b' % _1.to_i(16) }.join
  end

  def header
    version = @io.read(3).to_i(2)
    @version_counter += version
    type_id = @io.read(3).to_i(2)

    [version, type_id]
  end

  def read_package_count(count)
    count.times.collect { decode }
  end
  
  def read_length(length)
    values = []
    start = @io.pos

    while @io.pos - start < length
      values << decode
    end

    values
  end
  
  # read the operator packet, can contain multiple packets that we have to decode
  def read
    length_type = @io.read(1).to_i(2)
    
    case length_type
    when 0 # 15 bytes = length, then read that amount of packages
      package_length = @io.read(15).to_i(2)
      read_length(package_length)
    when 1  # 11 bytes = length, then read packages until amount of bytes is read
      package_count = @io.read(11).to_i(2)
      read_package_count(package_count)
    else
      throw 'unknown state in operator packet'
    end
  end
  
  def literal_value
    value = []

    while (group = @io.read(5))
      value << group[1..-1]
      break if group.start_with?("0")
    end

    value.join.to_i(2)
  end

  def decode
    version, type = header
    @version_counter += version
    
    case type
    when 0 #sum
      read.sum
    when 1 #product
      read.inject(&:*)
    when 2 #minimum
      read.min
    when 3 #maximum
      read.max
    when 4 #literal
      literal_value
    when 5 #greater than
      a, b = read
      a > b ? 1 : 0
    when 6 #less than
      a,b = read
      a < b ? 1 : 0
    when 7 #equal
      a, b = read
      a == b ? 1 : 0
    else
      throw 'unknown state while decoding'
    end
  end
end

decoder = Decoder.new(file_content)

result = decoder.decode
puts "done #{result}"
