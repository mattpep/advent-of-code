START_ALLOCATION = [4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5]

def reallocate distribution
  index_of_largest = distribution.index distribution.max
  recipient = (index_of_largest + 1 ) % distribution.size
  to_distribute = distribution[index_of_largest]
  distribution[index_of_largest] = 0
  while to_distribute > 0
    distribution[recipient] += 1
    recipient += 1
    recipient %= distribution.size
    to_distribute -= 1
  end
  distribution
end

banks = START_ALLOCATION.dup
seen = [ banks.dup ]
while seen.count( seen.last) == 1
  banks = reallocate banks.dup
  seen << banks.dup
end

puts "Part 1: #{seen.count - 1}"
puts "Part 2: #{seen.count - (seen.index(seen.last))-1}"
