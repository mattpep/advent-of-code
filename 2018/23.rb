PATTERN = /pos=<(?<coords>-?\d+,-?\d+,-?\d+)>, r=(?<radius>\d+)/
data = ARGF.readlines.map &:strip

def distance_between bot1, bot2
  bot1.zip(bot2).map { |b1, b2| (b1 - b2).abs }.sum
end

bots = data.each_with_object(Array.new) do |record, arr|
  record.match(PATTERN) do |m|
    arr << {
      coords: m[:coords].split(',').map(&:to_i),
      radius: m[:radius].to_i
    }
  end
end

most_sensitive = bots.max_by { |b| b[:radius] }
part1 = bots.count do |bot|
  distance_between(bot[:coords], most_sensitive[:coords]) <= most_sensitive[:radius]
end

puts "Part 1: #{part1}"
