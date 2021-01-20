require_relative '../aoc/intcode_cpu'

memory = ARGF.read.split(',').map &:to_i

cpu = AOC::IntcodeCPU.new
cpu.load memory
cpu.input = 1
cpu.execute
part1 = cpu.output
puts "Part 1: #{part1}"

cpu.reset
cpu.load memory
cpu.input = 5
cpu.execute
part2 = cpu.output
puts "Part 2: #{part2}"
