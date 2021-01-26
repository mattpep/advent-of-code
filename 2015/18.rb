require_relative '../aoc/life_grid'

SIZE = 100
COUNT = 100
seed = ARGF.readlines.map { |line| line.strip.chars }


life = AOC::LifeGrid.new size: SIZE
life.cells.replace seed

COUNT.times { life.tick }
puts "Part 1: #{life.population}"
