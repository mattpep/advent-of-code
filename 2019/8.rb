WIDTH = 25
HEIGHT = 6

BLACK = 0
WHITE = 1
TRANSPARENT = 2

numbers = ARGF.read.strip.chars.map &:to_i
image_data = numbers.each_slice(WIDTH).to_a.each_slice(HEIGHT).to_a

zero_deficient_layer = image_data.min_by { |layer| layer.flatten.count(0) }

puts "Part 1: #{zero_deficient_layer.flatten.count(1) * zero_deficient_layer.flatten.count(2)}"


part2 = (0...HEIGHT).to_a.map do |y|
  (0...WIDTH).to_a.map do |x|
    cells = image_data.map { |layer| layer[y][x] }.reject{|color| color == TRANSPARENT}
    case cells.first
    when BLACK then ' '
    when WHITE then '#'
    end
  end
end

puts "Part 2"
puts part2.map(&:join).join "\n"

