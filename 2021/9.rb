require_relative '../aoc/seabed'

data = ARGF.readlines.map do |line|
  line.strip.chars.map &:to_i
end

seabed = AOC::Seabed.new data


puts "Part 1: #{seabed.risk_level}"

basins_by_size = seabed.basins.values.map(&:size).sort.reverse
puts "Part 2 #{basins_by_size[0...3].reduce(:*)}"
