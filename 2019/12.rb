require_relative '../aoc/moon_system'

moons = AOC::MoonSystem.new ARGF.readlines
1000.times { |_| moons.step }
puts "Part 1: #{moons.energy}"
