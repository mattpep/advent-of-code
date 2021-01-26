require_relative '../aoc/life_cube'

seed = [ARGF.readlines.map { |line| line.strip.chars }]


life = AOC::LifeCube.new expanding: true
life.cells = seed

6.times { life.tick }
puts "Part 1: #{life.population}"
