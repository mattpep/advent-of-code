data = ARGF.readlines.map(&:strip).map do |line|
  input, output = line.split(' | ')
  [input.split, output.split]
end

part1 = data.map(&:last).flatten.select { |segments| [2,3,4,7].include? segments.length }.count

puts "Part 1: #{part1}"
