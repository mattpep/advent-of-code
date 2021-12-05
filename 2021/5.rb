data = ARGF.readlines.map do |line|
  line.strip!
  line.split(' -> ').map do |coord|
    coord.split(',').map &:to_i
  end
end

hv_lines = data.select do |segment|
  segment[0][0] == segment[1][0] || segment[0][1] == segment[1][1]
end

grid_x = hv_lines.map { |segment| [segment[0][0], segment[1][0]].max }.max
grid_y = hv_lines.map { |segment| [segment[0][1], segment[1][1]].max }.max
grid = Array.new(grid_y+1) { Array.new(grid_x+1) { 0 } }

hv_lines.each do |segment|
  if segment[0][0] == segment[1][0] # X is the same, so line is vertical
    x = segment[0][0]
    # lines could run "up" or "down", so extract the top and bottom
    minmax = segment.transpose[1].minmax
    (minmax[0]..minmax[1]).each do |y|
      grid[y][x] += 1
    end
  else                              # Y is the same, so line is horizontal
    y = segment[0][1]
    # lines could run "leftwards" or "rightwards", so extract the endpoints
    minmax = segment.transpose[0].minmax
    (minmax[0]..minmax[1]).each do |x|
      grid[y][x] += 1
    end
  end
end


part1 = grid.flatten.count { |cell| cell >= 2 }

puts "Part 1: #{part1}"
