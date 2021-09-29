require_relative '../aoc/manhattan_grid'

path = ARGF.read.strip.chars
grid = AOC::ManhattanGrid.new

grid.walk(path) { |g| g.current_cell += 1 }
visit_count = grid.grid.sum do |row|
  row.filter { |cell| cell != 0 }.count
end

puts "Part 1 - Visited house count: #{visit_count}"


grid = AOC::ManhattanGrid.new
grid.grid[0][0] = 99

santa_path, robo_path = path.each_slice(2).
                             each_with_object([[], [] ]) do |pair, arr|
                               arr[0] << pair[0]
                               arr[1] << pair[1]
                             end

grid.walk(santa_path) { |g| g.current_cell += 1 }
grid.home!
grid.walk(robo_path) { |g| g.current_cell += 1 }

visit_count = grid.grid.sum do |row|
  row.filter { |cell| cell != 0 }.count
end
puts "Part 2 - Visited house count: #{visit_count}"
