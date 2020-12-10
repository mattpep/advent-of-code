outputs = ARGF.readlines.map &:to_i
DEVICE_THRESHOLD = 3

diffs = outputs.sort.each_cons(2).map { |a,b| b-a }
diffs.insert(0,1) # start with joltage of 0
diffs << DEVICE_THRESHOLD
part1 = diffs.count(1) * diffs.count(3)

puts "Part 1: #{part1}"
