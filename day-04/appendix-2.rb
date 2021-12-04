# via https://www.reddit.com/r/adventofcode/comments/r8i1lq/2021_day_4_solutions/hn5wr4x/

# wow that's cool 
# instead of subtracting I could just have used include as I was close with the transpose idea 
(board + board.transpose).any? { |line| line.all? { |n| drawn.include?(n) } }
