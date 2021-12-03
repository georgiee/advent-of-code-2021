path = File.join(__dir__, 'input.txt')
input = File.read(path)

puts " day 3"

numbers = input.split

def calculate_gamma(numbers)
  bit_layers = numbers.map {|binary| binary.split("")}.transpose
   bit_layers.map do |number|
    number.count("1") >= number.count("0") ? "1" : "0"
  end.join
end

def calculate_epsilon(numbers)
  bit_layers = numbers.map {|binary| binary.split("")}.transpose
   bit_layers.map do |number|
    number.count("0") <= number.count("1") ? "0" : "1"
  end.join
end

def calculate_oxygen (numbers)
  0xffff.to_s(2).length.times do |index|
    gamma = calculate_gamma(numbers)

    numbers = numbers.filter do |number|
      number[index].eql?(gamma[index])
    end
  end
  
  numbers[0]
end

def calculate_co2 (numbers)
  0xffff.to_s(2).length.times do |index|
    epsilon = calculate_epsilon(numbers)
    
    numbers = numbers.filter do |number|
      number[index].eql?(epsilon[index])
    end
    
    if numbers.count == 1
      break
    end
    
    numbers
  end

  puts numbers[0]
  numbers[0]
end

oxygen = calculate_oxygen(numbers.clone).to_i(2)
co2 = calculate_co2(numbers.clone).to_i(2)
result = oxygen * co2
puts result
