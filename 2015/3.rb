require_relative '../aoc/manhattan_grid'

path = ARGF.read.strip.chars
grid = AOC::ManhattanGrid.new

grid.walk(path) { |g| g.current_cell += 1 }
visit_count = grid.grid.sum do |row|
  row.filter { |cell| cell != 0 }.count
end

puts "Visited house count: #{visit_count}"
