require_relative '../aoc/intcode_cpu'

memory = ARGF.read.split(',').map &:to_i

PART2_TARGET = 19690720

cpu = AOC::IntcodeCPU.new
cpu.load memory
puts "Part 1: #{cpu.execute [12,02] }"

(0..99).each do |x|
  (0..99).each do |y|
    cpu.reset
    cpu.load memory
    cell0 = cpu.execute [x,y]
    if cell0 == PART2_TARGET
      puts "Part 2: #{100*x + y}"
      exit
    end
  end
end
