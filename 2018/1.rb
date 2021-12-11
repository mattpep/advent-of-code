numbers = ARGF.readlines.map(&:to_i)

puts "Part 1: #{numbers.sum}"

sums = []
while true
  numbers.each do |freq_change|
    # puts "Looking at freq change: #{freq_change}"
    sums << sums.last.to_i + freq_change
    # puts "Just added #{sums.last}, freq sums are #{sums}"
    if sums.count(sums.last) == 2
      puts "Part 2: #{sums.last}"
      exit
    end
  end
end
