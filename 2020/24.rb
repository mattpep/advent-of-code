require_relative '../aoc/hexgrid'

paths = ARGF.readlines.map &:strip

WHITE = false
BLACK = true
GRID_SIZE = 40

def split_path pathstring
  pathstring.chars.each_with_object([]).with_index do |(char, path), index|
    case char
    when 'e', 'w'
      if pathstring[index-1] == 'n' || pathstring[index-1] == 's'
        path << pathstring[index-1..index]
      else
        path << pathstring[index]
      end
    end
  end
end

grid = AOC::HexGrid.new(GRID_SIZE, WHITE)

paths.each do |pathstring|
  x = (GRID_SIZE/2).floor
  y = (GRID_SIZE/2).floor
  x,y = grid.walk_path([x,y], split_path(pathstring))
 grid[y][x] = !grid[y][x]
end

part1 = grid.count(BLACK)

puts "Part 1: #{part1}"
