require_relative '../aoc/seating_plan'

data = ARGF.readlines.map(&:strip)

seating_plan = AOC::SeatingPlan.new data

while true
  seating_plan.tick
  break if seating_plan.changed == false
end

puts "part1: Population after a repeat is #{seating_plan.population}"
