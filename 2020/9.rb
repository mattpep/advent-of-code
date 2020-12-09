numbers = ARGF.readlines.map(&:strip).map &:to_i

WINDOW_SIZE=25


def valid? window_size, list
  target = list.last
  list[0..-1].combination(2).to_a.any? { |a,b| a+b == target }
end


part1 = numbers.each_cons(WINDOW_SIZE+1).reject { |window| valid? WINDOW_SIZE, window }.first.last
puts "Part 1: #{part1}"

(0...(numbers.size)).each do |lower|
  next if lower > part1
  ((lower+1)...(numbers.size)).each do |upper|
    range_sum = numbers[lower..upper].sum
    break if range_sum > part1
    if range_sum == part1
      part2 = numbers[lower..upper].minmax.sum
      puts "Part 2: #{ part2 }"
      exit
    end
  end
end
