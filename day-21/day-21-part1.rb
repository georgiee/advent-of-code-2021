require 'benchmark'
require 'stringio'
require "enumerator"

file_content = File.read(File.join(__dir__, 'input.txt'))
start_a, start_b = file_content.scan(/\d+$/).map(&:to_i)


DETERMINISTIC_DIE = Enumerator.new do |yielder|
  side = 0
  rolls = 0
  loop do
    rolls += 1
    side = 0 if side >= 100

    side += 1
    yielder << [rolls, side]
    
  end
end 



class Player
  attr_accessor :score
  
  def initialize(start, name)
    @name = name
    @space = start
    @score = 0
  end
  
  def play(values)
    @space = (@space + values.sum - 1) % Game::MAX_SPACE + 1
    @score += @space
    # not 0 based so shift forth and back the num
    puts "#{@name}: #{@space} (#{@score})"
  end
  
  def wins?
    @score >= Game::MAX_SCORE
  end
end

class Game
  MAX_SPACE = 10
  MAX_SCORE = 1000
  
  def initialize(start_a, start_b)
    @die = DETERMINISTIC_DIE
    @rounds = 0
    @p_a = Player.new(start_a, "Player A")
    @p_b = Player.new(start_b, 'Player B')
  end
  
  def play
    until @p_a.wins? || @p_b.wins?
      @rounds += 1
      @p_a.play(3.times.collect{ @die.next[1] })
      break if @p_a.wins?
      
      @rounds += 1
      @p_b.play(3.times.collect{ @die.next[1] })
      break if @p_b.wins?
    end

    min_score = [@p_a.score, @p_b.score].min
    rolls = @die.peek[0] - 1
    
    
    result = min_score * rolls
    puts "result #{result}"
  end
end


game = Game.new(start_a, start_b)
game.play
