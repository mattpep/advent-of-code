require_relative '../aoc/hexgrid'

paths = ARGF.readlines.map &:strip

WHITE = false
BLACK = true
GRID_SIZE = 150
DAY_COUNT = 100

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

DAY_COUNT.times do |day|
  (0...GRID_SIZE).to_a.each do |x|
    (0...GRID_SIZE).to_a.each do |y|
      black_neighbours = grid.neighbours_of([x,y]).map{|k,v| k.values[0]}
      black_neighbour_count = black_neighbours.count { |nx,ny| grid.grid[ny][nx] == BLACK }
      case grid.grid[y][x]
      when BLACK
        if black_neighbour_count == 0 || black_neighbour_count > 2
          grid.prepare_move([x,y], WHITE)
        end
      when WHITE
        if black_neighbour_count == 2
          grid.prepare_move([x,y], BLACK)
        end
      end
    end
  end
  grid.commit_prepared_moves!
end

part2 = grid.count(BLACK)
puts "Part 2: after day #{DAY_COUNT}, number of black tiles is #{part2}"
