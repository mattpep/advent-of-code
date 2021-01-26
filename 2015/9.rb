data = ARGF.readlines.map &:strip


PATTERN = /(?<place1>\w+) to (?<place2>\w+) = (?<distance>\d+)/
places = data.map do |record|
  fields = record.split
  [fields[0], fields[2]]
end.flatten.uniq.sort

distances = data.each_with_object(Hash.new) do |record, hash|
  record.match(PATTERN) do |m|
    place1 = places.index m[:place1]
    place2 = places.index m[:place2]
    key = [place1, place2].sort

    hash[key] = m[:distance].to_i
  end
end

part1 = (0...(places.count)).to_a.permutation.map do |route|
  route.each_cons(2).map { |hop| distances[hop.sort] }.sum
end.min

puts "Part 1: #{part1}"

part2 = (0...(places.count)).to_a.permutation.map do |route|
  route.each_cons(2).map { |hop| distances[hop.sort] }.sum
end.max

puts "Part 2: #{part2}"
