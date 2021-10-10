INITIAL = 'cqjxjnds'

def valid? password
  return false unless password.chars.each_cons(3).any? { |a, b, c | b.ord == a.ord + 1 && c.ord == b.ord + 1 }
  return false if 'oil'.chars.any? { |forbidden| password.include? forbidden }
  return false unless password.chars.each_cons(2).select { |a, b| a == b }.flatten.uniq.length >= 2
  true
end

password = INITIAL
until valid? password
  password.next!
end

puts "Part 1: #{ password }"

password.next!

until valid? password
  password.next!
end

puts "Part 2: #{ password }"
