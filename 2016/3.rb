triangles = ARGF.readlines.map(&:strip)

part1 = triangles.select do |triangle|
  sides = triangle.split.sort.map(&:to_i)
  sides.all? do |s|
    a = s
    b = sides.sum - s
    a < b
  end
end.count

puts "Part 1: #{part1}"
