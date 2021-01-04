digits = ARGF.read.strip.chars.map(&:to_i)

total = digits.each_cons(2).select do |a,b|
  a == b
end.map(&:first).sum

total += digits.first if digits.first == digits.last

puts "Part 1 solution: #{total}"


offset = digits.length / 2

total = digits.each_with_index.select do |digit, idx|
  digits[(idx+offset)%digits.length] == digit
end.map(&:first).sum

puts "Part 2 solution: #{total}"
