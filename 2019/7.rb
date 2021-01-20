require_relative '../aoc/intcode_cpu'

memory = ARGF.read.split(',').map &:to_i

part1 = (0...5).to_a.permutation(5).map do |phases|

  amplifiers = Array.new(5) { AOC::IntcodeCPU.new }
  5.times do |a|
    if a == 0
      amplifiers[0].input = [phases.first, 0]
    else
      amplifiers[a].input = [phases[a],  amplifiers[a-1].output ]
    end
    amplifiers[a].load memory
    amplifiers[a].execute
  end
  amplifiers[4].output
end.max

puts "Part 1: #{ part1 }"
