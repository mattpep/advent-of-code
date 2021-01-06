box_ids = ARGF.readlines.map &:strip

double_count = box_ids.count { |id| id.chars.any? { |ch| id.count(ch) == 2 } }
triple_count = box_ids.count { |id| id.chars.any? { |ch| id.count(ch) == 3 } }


puts "Part1: #{ double_count * triple_count }"

class Array
  # return an array without the item at the specified index
  def omit idx
    entries[0...idx] + entries.drop(1+idx)
  end
end


box_ids.combination(2).each do |pair|
  first, second = pair
  first.length.times do |idx|
    next if first.chars.omit(idx) != second.chars.omit(idx)
    puts "Part 2: #{first.chars.omit(idx).join}"
    exit
  end
end
