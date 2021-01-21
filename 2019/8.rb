WIDTH = 25
HEIGHT = 6

numbers = ARGF.read.strip.chars.map &:to_i
image_data = numbers.each_slice(WIDTH).to_a.each_slice(HEIGHT).to_a

zero_deficient_layer = image_data.min_by { |layer| layer.flatten.count(0) }

puts "Part 1: #{zero_deficient_layer.flatten.count(1) * zero_deficient_layer.flatten.count(2)}"
