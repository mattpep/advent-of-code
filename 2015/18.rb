require_relative '../aoc/life_grid'

SIZE = 100
COUNT = 100
seed = ARGF.readlines.map { |line| line.strip.chars }


life = AOC::LifeGrid.new size: SIZE
life.cells.replace seed

COUNT.times { life.tick }
puts "Part 1: #{life.population}"


life.cells.replace seed

COUNT.times do
  life.tick
  life.cells[0][0] = AOC::LifeGrid::OCCUPIED
  life.cells[-1][0] = AOC::LifeGrid::OCCUPIED
  life.cells[0][-1] = AOC::LifeGrid::OCCUPIED
  life.cells[-1][-1] = AOC::LifeGrid::OCCUPIED
end
puts "Part 2: #{life.population}"
