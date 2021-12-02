data = ARGF.readlines

depth1 = 0
depth2 = 0
x = 0

data.each do |instr|
  direction, distance = instr.split

  case direction
  when 'forward'
    x += distance.to_i
    depth2 += depth1*distance.to_i
  when 'up'
    depth1 -= distance.to_i
  when 'down'
    depth1 += distance.to_i
  end
end

part1 = x * depth1
puts "Part 1: #{part1}"

part2 = x * depth2
puts "Part 2: #{part2}"
