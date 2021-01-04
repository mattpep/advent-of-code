numbers = ARGF.readlines.map do |row|
  row.split.map &:to_i
end

part1 = numbers.map do |row|
  row.minmax.reduce(&:-).abs
end.sum

puts "Part 1: #{part1}"

part2 = numbers.map do |row|
  row.combination(2).map do |pair|
    if pair[0] > pair[1]
      r = pair[0].divmod pair[1]
    else
      r = pair[1].divmod pair[0]
    end
    r[0] if r && r[1] == 0
  end.reject(&:nil?)[0]
end.sum
puts "Part 2: #{part2}"
