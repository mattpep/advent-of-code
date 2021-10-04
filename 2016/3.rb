triangles = ARGF.readlines.map(&:strip).map { |row| row.split.map &:to_i }

part1 = triangles.select do |sides|
  # sides = triangle.split.sort.map(&:to_i)
  sides.all? do |s|
    a = s
    b = sides.sum - s
    a < b
  end
end.count

puts "Part 1: #{part1}"


part2 = triangles.each_slice(3).map(&:transpose).flatten(1).select do |sides|
  sides.all? do |s|
    a = s
    b = sides.sum - s
    a < b
  end
end.count

puts "Part 1: #{part2}"
