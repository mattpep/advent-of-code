require 'net/http'

TARGET = 2020

numbers = ARGF.read.split("\n").map(&:to_i)

# Though in my input there are no duplicated numbers, we don't know whether
# that's the general case. So we dedupe by index rather than value

numbers.each_with_index do |x, idx_x|
  numbers.each_with_index do |y, idx_y|
    next if idx_x == idx_y
    if x + y == TARGET
      puts "Found a match for #{x} and #{y}. Product is #{x*y}"
      exit 0
    end
  end
end

puts "No solutions found :-("
