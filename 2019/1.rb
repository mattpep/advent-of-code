masses = ARGF.readlines.map &:to_i

fuel = masses.sum { |mass| (mass / 3).floor - 2 }

puts "Part 1: #{fuel}"
