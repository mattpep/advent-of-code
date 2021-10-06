RANGE = 197487..673251

STRICT = 0
TOLERANT = 1

def run_length_encode(i)
  i.digits.slice_when { |x,y| x!= y}.map{ |x| [x.count, x[0]]}
end

def validate n, mode=TOLERANT
  rle = run_length_encode(n)
  if mode == STRICT
    return false unless rle.any? { |count,_| count == 2 }
  else
    return false unless rle.any? { |count,_| count >= 2 }
  end
  # return false unless RANGE.include? n
  return true if n.digits.each_cons(2).all? { |b,a| a <= b }
end

part1 = RANGE.first.upto(RANGE.last).count { |x| validate x }
puts "Part 1: #{part1}"

part2 = RANGE.first.upto(RANGE.last).count { |x| validate x, STRICT }
puts "Part 2: #{part2}"
