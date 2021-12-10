require 'benchmark'

path = File.join(__dir__, 'input.txt')
lines = *File.readlines(path).map {_1.chomp!}

BRACKETS_CLOSE = "]}>)".chars
BRACKETS_OPEN = "[{<(".chars
BALANCED_BRACKETS = BRACKETS_OPEN.zip(BRACKETS_CLOSE)

POINTS = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

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
      # puts "error, expected #{complement} but got #{bracket}"
      return bracket
    end

    if closing && paired
      stack = stack[..-2]
    else
      stack << bracket
    end
  end

  nil
end

def remove_balanced(line)
  stack = []

  line.chars.each do |char|
    if stack.empty?
      stack << char
      next
    end

    pair = [stack.last, char]
    balanced = BALANCED_BRACKETS.include? pair
    if balanced
      stack.pop
      # drop
    else
      stack << char
    end
  end

  remaining = stack.join
  if remaining.size < line.size
    # still work to do
    remove_balanced(remaining)
  else
    remaining
  end
end

def line_score(line)
  result = remove_balanced line
  complement = result.chars.map {get_complement(_1)}.reverse.join
  
  complement.chars.inject(0) do |memo, value|
    score = POINTS[value]
    memo * 5 + score 
  end
end

only_completed = lines.reject { |line| corrupt?(line) }
scores = only_completed.map { line_score(_1) }

middle_score = scores.sort[(scores.size - 1)/2]
puts middle_score

