require_relative '../aoc/orbit_map'

orbit_map = AOC::OrbitMap.new ARGF.read

puts "Part 1: #{ orbit_map.count_orbits }"
puts "Part 2: #{ orbit_map.count_transfers_from('YOU', 'SAN') }"
