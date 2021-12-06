# 1. group by & transform values
# via https://www.reddit.com/r/adventofcode/comments/r9z49j/2021_day_6_solutions/hnffzni/
# I created the hash very naively and I found this which is much more elegant
# mine: initial_state.inject(Hash.new(0)) { |hash, value| hash[value] += 1; hash }`
initial_state.group_by {_1}.transform_values(&:count)

# 2. tiny solution
# This is so awesome. You can even read and understand it. 
# The module is a great idea.
# https://www.reddit.com/r/adventofcode/comments/r9z49j/2021_day_6_solutions/hnfdhsi/
# f=[0]*9
# gets.scan(/\d/){f[_1.hex]+=1}
# 256.times{f[(_1+7)%9]+=f[_1%9]}
# p f.sum`
