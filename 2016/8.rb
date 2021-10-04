operations = ARGF.readlines.map &:strip

GRID_WIDTH = 50
GRID_HEIGHT = 6

class Array
  def transpose!
    replace self.transpose
  end
end

grid = Array.new(GRID_HEIGHT) { Array.new(GRID_WIDTH) { '.' } }

operations.each do |operation|
  op, *args = operation.split
  case op
  when 'rect'
    coords = operation.split[1].split('x').map &:to_i
    (0...coords[0]).each do |x|
      (0...coords[1]).each do |y|
        grid[y][x] = '#'
      end
    end
  when 'rotate'
    amount = args[3].to_i
    rowcol = args[1].split('=')[1].to_i
    if args[0] == 'row'
      grid[rowcol].rotate!(-amount)
    else # column
      grid = grid.transpose!
      grid[rowcol].rotate!(-amount)
      grid = grid.transpose!
    end
  end
end

part1 = grid.flatten.count '#'
puts "Part 1: #{part1}"

puts grid.map(&:join).join("\n")
