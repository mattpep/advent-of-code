masses = ARGF.readlines.map &:to_i

def fuel_for_mass mass
  (mass / 3).floor - 2 
end

fuel1 = masses.sum { |mass| fuel_for_mass mass }

puts "Part 1: #{fuel1}"

fuel2 = masses.sum do |mass|
  fuel = 0

  while ( extra = fuel_for_mass(mass) ) > 0
    fuel += extra
    mass = extra
  end
  fuel
end

puts "Part 2: #{fuel2}"
