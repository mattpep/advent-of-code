require_relative '../aoc/manhattan_grid'

data = ARGF.read.strip.chars
visit_count = AOC::ManhattanGrid.new(data).visited_houses
puts "Visited house count: #{visit_count}"
