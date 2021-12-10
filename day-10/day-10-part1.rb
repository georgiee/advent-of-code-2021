require 'benchmark'

path = File.join(__dir__, 'input.txt')
lines = *File.readlines(path).map {_1.chomp!}

BRACKETS_CLOSE = "]}>)".chars
BRACKETS_OPEN = "[{<(".chars
BALANCED_BRACKETS = BRACKETS_OPEN.zip(BRACKETS_CLOSE)

def get_complement(bracket)
  closing = BRACKETS_CLOSE.include? bracket
  if closing
    BALANCED_BRACKETS.detect { _1[1].eql? bracket}[0]
  else
    BALANCED_BRACKETS.detect { _1[0].eql? bracket}[1]
  end
end

def corrupt?(line)
  not first_corrupt(line).nil?
end

def first_corrupt(line)
  stack = []
  stack << line.chars.first
  
  line.chars.drop(1).each do |bracket|
    last_bracket = stack.last
    pair = [last_bracket, bracket]
    closing = BRACKETS_CLOSE.include? bracket
    paired = BALANCED_BRACKETS.include? pair
    
    if closing && !paired
      complement = get_complement(last_bracket)
      puts "error, expected #{complement} but got #{bracket}"
      return bracket
    end
    
    if closing && paired
      puts "closing #{pair} "
      stack = stack[..-2]
    else
      stack << bracket
    end
  end
  
  nil
end

POINTS = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

corrupts = lines.map {first_corrupt(_1)}.compact.sum { POINTS[_1]}

puts corrupts
# bracket_stack("[({(<(())[]>[[{[]{<()<>>")

# "[(()[<>])]({[<{<<[]>>(".chars.each{ bracket_stack(_1) }

# only_completed = lines.reject { |line| line.length.even? }

puts lines


#
# def bracket_stack(line, stack = [])
#   if line.empty?
#     puts "done"
#     exit
#   end
#
#   bracket = line.chars.first
#   last_bracket = stack.last
#
#   paired = BALANCED_BRACKETS.include? [last_bracket, bracket]
#   closing = BRACKETS_CLOSE.include? bracket
#   if closing && !paired
#     complement = get_complement(last_bracket)
#     puts "error, expected #{complement} but got #{bracket}"
#   end
#
#   if paired
#     # puts "found pair of #{bracket}"
#     stack = stack[..-2]
#   else
#     stack << bracket
#   end
#
#   next_line = line.chars.drop(1).join
#   bracket_stack(next_line, stack)
# end
