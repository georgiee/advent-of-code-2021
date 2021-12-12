require 'benchmark'

path = File.join(__dir__, 'input.txt')
input = *File.readlines(path).map {_1.chomp!}.map{ |row| row.split("").map{_1.to_i}}

# never started, failed in part 1
