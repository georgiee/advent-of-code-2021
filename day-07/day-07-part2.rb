require 'benchmark'

path = File.join(__dir__, 'input.txt')
input = File.read(path).split(',').map(&:to_i)

range = (input.min..input.max)

# create a cache for the calculation of the triangle number
TRIANGLE_CACHE = {}
TRIANGLE_CACHE.default_proc = proc do |hash, key|
  hash[key] = triangle_number(key)
end

# search for factorial but with addition
# and got my hands on the name of the "algorithm"
def triangle_number(n)
  n*(n+1)/2
end

def cost_to_align(input, position)
  input.inject(0) do |memo, value|
    memo + TRIANGLE_CACHE[(value - position).abs]
  end
end

# 4.107515   0.035291   4.142806 (  4.181258)
puts Benchmark.measure {
  result = range.to_a.map do |position|
    fuel = cost_to_align(input, position)
    [position, fuel]
  end
  
  puts result.min_by {  _1[1]}[1]
}
