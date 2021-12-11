require 'benchmark'

path = File.join(__dir__, 'input.txt')
input = *File.readlines(path).map {_1.chomp!}.map{ |row| row.split("").map{_1.to_i}}



class Octopus
  attr_reader :x, :y, :energy
  # collect all variations but remove duplicates, these are all of our neighbor locations
  NEIGHBORS = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]
  def initialize(x:, y:, energy:)
    @x, @y = x, y
    @energy = energy
    @flash = false
  end

  def location
    [x,y]
  end
  
  def neighbors
    NEIGHBORS.map {[@x + _1[0], @y + _1[1]]}
  end
  
  def increase
    @energy += 1
  end

  def can_flash?
    @energy > 9 && !@flash
  end


  def just_flashed?
    @energy == 0
  end

  def power_up!
    @energy += 1
  end

  def on!
    @flash = true
  end
  
  def on?
    @flash
  end
  
  def off!
    @flash = false
    @energy = 0
  end
end

class Cave
  def initialize (levels)
    @folks = {}
    
    levels.each.with_index do |line, y|
      line.each.with_index do |val, x|
        @folks[[x, y]] = Octopus.new(x: x, y: y, energy: val)
      end
    end
  end
  
  def everyone
    @folks.values
  end

  def [](location)
    @folks[location]
  end
  
  def all(list)
    list.map { self[_1] }.compact
  end
  
  def step
    everyone.map(&:increase)
    
    while can_flash?
      everyone.filter(&:can_flash?).each do |octopus|
        octopus.on!
        all(octopus.neighbors).map(&:power_up!)
      end
    end

    clean_up
  end
  
  def process(count)
    count.times.collect do
      step
      who_flashed?
    end.inject(0) {|memo, list| memo + list.size}
  end
  
  def clean_up
    everyone.filter(&:on?).each do |octopus|
      octopus.off!
    end
  end

  def anyone_flashed?
    everyone.any(&:just_flashed?)
  end
  
  def who_flashed?
    everyone.filter(&:just_flashed?)
  end
  
  def can_flash?
    everyone.any?(&:can_flash?)
  end
  
  def print
    result = []
    @folks.each do  |k, v|
      result[k[1]] = [] if result[k[1]].nil?
      result[k[1]][k[0]] = [] if result[k[1]][k[0]].nil?
      result[k[1]][k[0]] = v.energy
    end
    
    result.each { puts _1.join("")}
  end
  
end


cave = Cave.new(input)

result = cave.process(100)
cave.print

puts "flashes #{result}"
