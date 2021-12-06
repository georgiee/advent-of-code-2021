require 'benchmark'

path = File.join(__dir__, 'input.txt')
input = File.read(path).split(',').map(&:to_i)

initial_state = input.clone


fishlife = Enumerator.new do |yielder|
  next_state = initial_state
  
  loop do
    next_state = next_state.inject([]) do |memo, value|
      if value == 0
        memo << 8
        memo << 6
      else
        memo << value - 1
      end

      memo
    end
    
    yielder << next_state
    
  end
end



time = Benchmark.measure {
  puts fishlife.take(80).to_a.last.size
}

# 345387
# in 0.35545699996873736s
puts time.real
