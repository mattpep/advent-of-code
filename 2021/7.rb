data = ARGF.readline.strip.split(',').map &:to_i

part1 = (data.min..data.max).map do |target|
  data.map { |item| (item - target).abs }.sum
end.min


puts "Part 1: #{part1}"

part2 = (data.min..data.max).map do |target|
  data.map { |item| (1..(item - target).abs).sum }.sum
end.min


puts "Part 2: #{part2}"
