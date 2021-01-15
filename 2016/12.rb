require_relative '../aoc/assembunny_cpu'

program = ARGF.readlines.map &:strip
cpu = AOC::AssembunnyCPU.new

cpu.execute program
puts "Part 1: #{cpu.a}"

cpu.reset
program.prepend 'cpy 1 c'
cpu.execute program
puts "Part 2: #{cpu.a}"
