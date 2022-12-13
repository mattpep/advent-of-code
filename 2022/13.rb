pairs = ARGF.read.split("\n\n").map { |s| s.split("\n").map { |s| eval(s) } }

def compare(left, right)
  if left.nil? && right.nil?
    return 0
  elsif right.nil?
    return 1
  elsif left.nil?
    return -1
  elsif left.class == Integer && right.class == Integer
    left <=> right
  elsif left.class == Integer && right.class == Array
    compare([left], right)
  elsif left.class == Array && right.class == Integer
    compare(left, [right])
  elsif left.class == Array && right.class == Array
    r = compare(left.first, right.first)
    return r unless r.zero?
    compare(left[1..-1], right[1..-1])
  else
    raise "Unknown types #{left.class.inspect} and #{right.class.inspect}"
  end

end

comparisons = pairs.each_with_index.map do |pair, idx|
  left, right = pair

  result = compare(left, right)
  [idx.succ, result]
end

part1 = comparisons.select { |_, order| order == -1 }.map(&:first)
puts "Part 1 (in-order count): #{part1.sum}"

DIVIDERS = [ [[2]], [[6]] ]
all_records = pairs.flatten(1) + DIVIDERS

sorted = all_records.sort { |a,b| compare(a,b) }

key = DIVIDERS.map do |divider|
  index = sorted.index(divider)+1
end.reduce(:*)


puts "Part 2 (decoder key): #{key}"
