phrases = ARGF.readlines.map &:split

part1 = phrases.count do |words|
  words.all? { |word| words.count(word) == 1 }
end

puts "Part 1 : #{part1}"

part2 = phrases.count do |words|
  sorted_words = words.map { |word| word.chars.sort.join }
  words.all? { |word| sorted_words.count(word.chars.sort.join) == 1 }
end

puts "Part 2 : #{part2}"
