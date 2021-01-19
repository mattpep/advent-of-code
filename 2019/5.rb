require_relative '../aoc/intcode_cpu'

memory = ARGF.read.split(',').map &:to_i

cpu = AOC::IntcodeCPU.new
cpu.load memory
cpu.input = 1
cpu.execute
part1 = cpu.output

puts "Part 1: #{part1}"
