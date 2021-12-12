require 'benchmark'

path = File.join(__dir__, 'input.txt')
lines = *File.readlines(path).map {_1.chomp!}
input = lines.map{ |line| line.split("-") }

class Cave
  attr_accessor :name, :connections
  
  def initialize(name)
    @visit_counter = 0
    @name = name
    @connections = []
  end
  
  def small?
    @name == @name.downcase
  end
  
  def start?
    @name == "start"
  end
  
  def explorable?
    return false if start?
    return @visit_counter < 1 if small?
    
    true
  end
  
  def visit!
    @visit_counter += 1
  end
  
  def add_connection(other_cave)
    @connections << other_cave
  end
  
  def to_s
    "'#{@name}'"
  end

end

class Caves
  def initialize(caves, map)
    @caves = caves
    @map = map
  end
  
  def step
    
  end
  
  def start
    @caves.find
  end
  
  
end

caves = input.flatten.uniq.map{ Cave.new(_1) }.inject({}) {|memo, cave| memo[cave.name] = cave; memo}

input.map{ |a,b| [caves[a], caves[b]] }.each do | a,b |
  a.add_connection(b)
  b.add_connection(a)
end

def visit(cave, path = [])
  cave.visit!
  path += [cave]
  
  puts "walking: #{path.join(', ')}"
  
  if cave.name == "end"
    puts "end reached: #{path.join(',')}"
    return path
  else
    # divert into multiple direction and collect the paths
    cave.connections.map do |other_cave|
      if other_cave.explorable?
        if other_cave.name == 'b'
          puts 'o'
        end
        puts "visit: #{cave} -> #{other_cave}"
         visit(other_cave, path)
      else
        path
      end
    end
  end
end


list = visit(caves['start'])

puts "ok"
