VALID_PATTERNS = %w[
  abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg
]

INPUT = 0
OUTPUT = 1

data = ARGF.readlines.map(&:strip).map do |line|
  input, output = line.split(' | ')
  [input.split, output.split]
end

part1 = data.map(&:last).flatten.count { |segments| [2,3,4,7].include? segments.length }

puts "Part 1: #{part1}"

def decode row
  'abcdefg'.chars.permutation(7).each do |perm|
    if row[INPUT].all? { |input| VALID_PATTERNS.include?(input.tr('abcdefg', perm.join).chars.sort.join) }
      return row[OUTPUT].map {|digit| VALID_PATTERNS.index((digit.tr 'abcdefg', perm.join).chars.sort.join) }.join.to_i
    end
  end
end


part2 = data.sum { |record| decode record }
puts "Part 2: #{part2}"
