strings = ARGF.readlines.map(&:strip)
VOWELS = 'aeiou'
FORBIDDEN = %w( ab cd pq xy )

def check1 string
  return false if string.count(VOWELS) < 3
  return false unless string.chars.each_cons(2).any? { |x,y| x == y }
  return false if string.chars.each_cons(2).any? { |pair| FORBIDDEN.include? pair.join }
  true
end

def check2 string
  return false unless (0...(string.length-1)).any? do |x|
    pair = string[x..x+1]
    remainder = string[x+2..-1]
    remainder.include? pair
  end
  return false unless string.chars.each_cons(3).any? { |x,y,z| x == z }
  true
end

part1 = strings.select { |s| check1 s }
puts "Part 1 solution: #{part1.count}"

part2 = strings.select { |s| check2 s   }
puts "Part 2 solution: #{part2.count}"
