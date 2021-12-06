require 'benchmark'

path = File.join(__dir__, 'input.txt')
input = File.read(path).split(',').map(&:to_i)

initial_state = input.clone
initial_life = initial_state.inject(Hash.new(0)) { |hash, value| hash[value] += 1; hash } 

# This was growing an array for part 1 with is super inefficient. 
# I could have expected this for day 6 😅
# Hash is super performant
fishlife = Enumerator.new do |yielder|
  last_day = initial_life.clone
  
  loop do
    next_life = Hash.new(0)
    last_day.each do |remaining_life, fish_count|
      if remaining_life == 0
        next_life[8] += fish_count # spawn
        next_life[6] += fish_count # reset
      else
        next_life[remaining_life - 1] += fish_count
      end
    end

    last_day = next_life
    yielder << next_life
  end
end

# 0.003041   0.000074   0.003115 (  0.003129)
puts Benchmark.measure {
  puts "Result it #{fishlife.take(256).last.values.sum}"
}

