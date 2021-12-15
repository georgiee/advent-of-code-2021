require 'benchmark'

# not my solution, not submitted, just as a reference
# as this problem nagged me all day
# via https://topaz.github.io/paste/#XQAAAQDHAwAAAAAAAAA4G8nPaRVx/o1ZZYKycGL0SspRCXDQTQUVmHvXfVLEqraSWb0elNeZvnSclxpoFwVtzGktWmOe/XRTtEUmBAOBYzfSLnqEuShWc7DJrSu/wnPgm5XHzf4ctTUjOJhE1iC3FndYgzu3V2InBzTUhniHJP7rQreNtZQB5QWeHZ31bmzByLve13RoeaZt5XSmXhW9Pb/IE1pIlwmTIrQQSKCY0BgD+vhhAtmITSlv3PocxzxYS2LC55RCSGutN6OXlsCCDP/kZ3pIP79XYyqfnmZMgXD7W/6TXztLcx3Dup5qlr8zQxhIJ7C/D1n4o6rQSEDUS5wuY30dvfirzIjzf4pMjifsLJYeaZAyulqxCJBaIZYWP/YFfdWM4JlBKlN+RWgDJYVHvMAyMKsQ34L2HMk8vdB5U9yeFaHJwuCs9qNhumZ1SkclHblRBmB0kFBdWx/Sj/0k5+tGMKPE4+z195Mhn/p1RV9ZJt6wRcFJPo552hzd8IywsjWu+3E1iasGYKOfqHFo3mcjGyTS9IjHisWwqxbTivh6ii//tZt3Pg==

path = File.join(__dir__, 'input.txt')
polymer_template, pair_insertion_rules = *(File.read(path).split("\n\n"))

@rules = {}
@current_pairs = Hash.new(0)
@element_tally = Hash.new(0)

pair_insertion_rules.each_line(chomp: true) do |line|
  pair, insert = line.split(" -> ")
  @rules[pair] = insert
end

polymer_template.chars.each_cons(2) { |pair| @current_pairs[pair.join] += 1 }
polymer_template.chars.each { |char| @element_tally[char] += 1 }

40.times do |step|
  if step == 10
    min, max = @element_tally.minmax_by { |_k, v| v }
    puts "part 1: #{max[1] - min[1]}"
  end
  @current_pairs.clone.each do |pair, pair_occurances|
    element_to_be_insert = @rules[pair]
    @element_tally[element_to_be_insert] += pair_occurances
    @current_pairs[pair] -= pair_occurances
    @current_pairs[pair[0] + element_to_be_insert] += pair_occurances
    @current_pairs[element_to_be_insert + pair[1]] += pair_occurances
  end
end

min, max = @element_tally.minmax_by { |_k, v| v }
puts "part 2: #{max[1] - min[1]}"

