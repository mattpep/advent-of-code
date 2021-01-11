require_relative '../aoc/two_reg_cpu'

program = ARGF.readlines.map &:strip

cpu1 = AOC::TwoRegCPU.new(a: 0)
cpu1.execute program

puts "Part 1: #{cpu1.b}"

cpu2 = AOC::TwoRegCPU.new(a: 1)
cpu2.execute program

puts "Part 2: #{cpu2.b}"
