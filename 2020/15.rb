STARTING = [ 15, 12, 0, 14, 3, 1 ]
COUNT = 2020


numbers = []

COUNT.times do |count|
  if count < STARTING.length
    numbers << STARTING[count]
  else
    seen_before = numbers.count(numbers.last) > 1
    if seen_before
      diff = numbers[0...-1].reverse.index(numbers.last)+1
      most_recent_occurence = numbers.count - numbers[0...-1].reverse.index(numbers.last)-1
      numbers << diff
    else
      numbers << 0
    end
  end
end

puts "Part 1: #{numbers.last}"
