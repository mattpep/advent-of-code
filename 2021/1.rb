data = ARGF.readlines.map &:to_i

part1 = data.each_cons(2).map { |a, b| a < b }.count(true)
puts "Part 1: #{part1}"

part2 = data.each_cons(3).map(&:sum).each_cons(2).map { |a, b| a < b }.count(true)
puts "Part 2: #{part2}"
