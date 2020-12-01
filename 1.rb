require 'net/http'

TARGET = 2020

NUMBERS = ARGF.read.split("\n").map(&:to_i)

# Though in my input there are no duplicated numbers, we don't know whether
# that's the general case. So we dedupe by index rather than value
def part1
  NUMBERS.each_with_index do |x, idx_x|
    NUMBERS.each_with_index do |y, idx_y|
      next if idx_x == idx_y
      if x + y == TARGET
        puts "Part 1 solution: Found a match for #{x} and #{y}. Product is #{x*y}"
        return true
      end
    end
  end
end

def part2
  NUMBERS.each_with_index do |x, idx_x|
    NUMBERS.each_with_index do |y, idx_y|
      next if idx_x == idx_y
      NUMBERS.each_with_index do |z, idx_z|
        next if idx_x == idx_z || idx_y == idx_z
        if x + y + z == TARGET
          puts "Part 2 solution: Found a match for #{x}, #{y} and #{z}. Product is #{x*y*z}"
          return true
        end
      end
    end
  end
end

part1 || puts("No solution found for part 1 :-(") && exit(1)
part2 || puts("No solution found for part 2 :-(") && exit(1)
