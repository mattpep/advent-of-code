fish = ARGF.readline.split(',').map(&:to_i).each_with_object({}) do |f, hash|
  hash[f] = hash[f].to_i.succ
end

NORMAL_DELAY = 6
FIRST_DELAY = 8
256.times do |i|
  growth = fish[0].to_i
  new_fish = fish.each_with_object({}) do |timer, hash|
    if timer[0] == 0
      hash[NORMAL_DELAY] = fish[0]
    else
      hash[timer[0].pred] = hash[timer[0].pred].to_i + fish[timer[0]]
    end
  end
  new_fish[FIRST_DELAY] = growth + new_fish[FIRST_DELAY].to_i
  fish = new_fish
  if i == 80.pred
    puts "Part 1: #{fish.values.sum}"
  end
end

puts "Part 2: #{fish.values.sum}"
