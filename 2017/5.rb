original = ARGF.readlines.map &:to_i

jumps = original.dup

ptr = 0
steps = 0

while jumps[ptr]
  next_ptr = ptr + jumps[ptr]
  jumps[ptr] += 1
  steps += 1
  ptr = next_ptr
end

puts "Part 1: #{steps}"


jumps = original.dup

ptr = 0
steps = 0

while jumps[ptr]
  next_ptr = ptr + jumps[ptr]
  jumps[ptr] += (jumps[ptr] >= 3 ) ? -1 : 1
  steps += 1
  ptr = next_ptr
end

puts "Part 2: #{steps}"
