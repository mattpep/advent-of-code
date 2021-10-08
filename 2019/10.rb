require_relative '../aoc/asteroid_field'

field = AOC::AsteroidField.new ARGF.read

best = field.best
puts "Part 1: #{ field.visible_from(best[0], best[1]).count }"
