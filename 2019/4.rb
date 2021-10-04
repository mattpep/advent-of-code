RANGE = 197487..673251

def validate n
  # return false if n < 100_000 || n > 999_999
  return false unless RANGE.include? n
  return false unless n.digits.each_cons(2).any? { |a,b| a == b }
  return true if n.digits.each_cons(2).all? { |b,a| a <= b }
end

part1 = RANGE.first.upto(RANGE.last).count { |x| validate x }
puts "Part 1: #{part1}"
