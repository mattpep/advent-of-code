SIZE = 300
SERIAL = 8979

grid = Array.new(SIZE) do |y|
  Array.new(SIZE) do |x|
    rack_id = x.succ + 10
    power = rack_id * y.succ
    power += SERIAL
    power *= rack_id
    power /= 100
    power %= 10
    power -= 5
  end
end

max_region = (1...(SIZE-3)).map do |y|
  (1...(SIZE-3)).map do |x|
    [grid[y-1][(x-1)..(x+1)] + grid[y][(x-1)..(x+1)] + grid[y+1][(x-1)..(x+1)], [x,y]]
  end.max_by { |s| s[0].sum }
end.max_by { |s| s[0].sum }

puts "Part 1: #{max_region[1]}"
