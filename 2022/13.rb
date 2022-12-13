pairs = ARGF.read.split("\n\n").map {|s| s.split("\n") }

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
  left = eval(pair[0])
  right = eval(pair[1])

  result = compare(left, right)
  [idx.succ, result]
end

part1 = comparisons.select { |_, order| order == -1 }.map(&:first)
puts "Part 1 (in-order count): #{part1.sum}"
