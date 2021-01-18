require_relative '../aoc/eris_grid'

seed = ARGF.readlines.map { |line| line.strip.chars }
grid = AOC::ErisGrid.new seed

history = [Marshal.load(Marshal.dump(grid.cells))]
epoch = 0

while true
  grid.tick
  break if history.include? grid.cells

  history << Marshal.load(Marshal.dump(grid.cells))
end

puts "Part 1: #{grid.bio_rating}"
