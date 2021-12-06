fish = ARGF.readline.split(',').map &:to_i

NORMAL_DELAY = 6
FIRST_DELAY = 8
80.times do |i|
  puts "population after #{i} days: #{fish.count}"
  growth = fish.count(0)
  fish.map! do |timer|
    timer == 0 ? NORMAL_DELAY : timer.pred
  end
  growth.times { fish.append FIRST_DELAY }
end

# puts "after 80 days: fish are: #{fish}"
puts fish.count
