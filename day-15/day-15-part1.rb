require 'benchmark'

file_content = File.read(File.join(__dir__, 'input.txt'))
input = file_content.each_line.map {_1.chomp.chars.map(&:to_i)}


# start_node = nodes.first
# end_node = nodes.last

class Node
  attr_accessor :h, :f, :g, :position, :parent, :risk
  def initialize(position, risk, parent = nil)
    @parent, @risk, @position = parent, risk, position
    @h, @f, @g = 0, 0, 0
  end
  
  def x
    @position[0]
  end
  
  def y
    @position[1]
  end

  def ==(other)
    other.class == self.class &&
    other.position == @position
  end
end

def astar(maze, start, goal)
  start_node = Node.new(start, maze[start[1]][start[0]])
  end_node = Node.new(goal, maze[goal[1]][goal[0]] )

  open_list = []
  closed_list = {}
  
  open_list << start_node
  
  maze_width = maze.first.size
  maze_height = maze.size
  iterations = 0
  until open_list.empty?
    iterations+=1
    current_node = open_list.min_by {_1.f}
    if iterations%100 == 0
      puts "iterations #{iterations}"
    end
    open_list.delete(current_node)
    closed_list[current_node.position] = current_node

    if current_node == end_node
      puts "end"
      path = []
      current = current_node
      puts "cost was #{current.g}"
      until current.nil?
        path << [current.position, current.risk]
        current = current.parent
      end
      puts "iterations #{iterations}"
      return path.reverse
    end

    children = [[-1, 0],  [0, 1], [1, 0], [0, -1]].inject([]) do |memo, (dx, dy)|
      nx = current_node.x + dx
      ny = current_node.y + dy
      next memo if nx < 0 || ny < 0 || nx > maze_width - 1 || ny > maze_height - 1
      
      memo << Node.new([nx, ny], maze[ny][nx], current_node)
      memo
    end

    children.each do |child|
      # closed list was an array before, fucking slow 😳 hash is better but still take 20 seoconds
      next if closed_list.key?(child.position)
      
      child.g = current_node.g + child.risk
      child.h = (end_node.x - child.x).abs + (end_node.y - child.y).abs #manhattan
      child.f = child.g + child.h

      already_open = open_list.any? { |open_node| open_node == child && child.g > open_node.g }
      next if already_open
      
      open_list << child
    end
  end
end



maze_width = input.first.size
maze_height = input.size

def print_path(path, width, height)
  height.times do |y|
    result = width.times.inject([]) do |memo, x|
      result = path.find{_1[0] == [x, y]}
      if result
        if block_given?
          memo << yield(result)
        else
          memo << "■"
        end
      else
        memo << "•"
      end
      memo
    end.join
    puts result
  end
end


puts Benchmark.measure {
  path = astar(input, [0, 0], [maze_width-1, maze_height-1])
  print_path(path, maze_width, maze_height)
}
# 
