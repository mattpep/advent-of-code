require_relative '../aoc/seabed'

data = ARGF.readlines.map do |line|
  line.strip.chars.map &:to_i
end

seabed = AOC::Seabed.new data


puts "Part 1: #{seabed.risk_level}"
