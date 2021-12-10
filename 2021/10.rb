require_relative '../aoc/syntax_engine'

records = ARGF.readlines.map do |record|
  AOC::SyntaxEngine.new record.strip
end

part1 = records.sum do |record|
  record.score
end

puts "Part 1: #{part1}"

autocomplete_scores = records.reject(&:corrupt).map(&:autocomplete_score).sort

part2 = autocomplete_scores[ autocomplete_scores.count / 2 ]
puts "Part 2: #{part2}"

