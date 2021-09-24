require_relative '../aoc/seating_plan'


data = ARGF.readlines.map(&:strip)

parts = [
  { tolerance: AOC::SeatingPlan::FUSSY, visibility: AOC::SeatingPlan::NEAR },
  { tolerance: AOC::SeatingPlan::TOLERANT, visibility: AOC::SeatingPlan::FAR },
]

parts.each_with_index do |part, i|
  seating_plan = AOC::SeatingPlan.new data, part[:tolerance], part[:visibility]

  while true
    seating_plan.tick
    break if seating_plan.changed == false
  end

  puts "part #{i+1}: Population after a repeat is #{seating_plan.population}"
end
