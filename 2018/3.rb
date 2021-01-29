PATTERN = /#(?<id>\d+) @ (?<left>\d+),(?<top>\d+): (?<width>\d+)x(?<height>\d+)/

SIZE = 1000
grid = Array.new(1000) { Array.new(1000) { Array.new } }

claims = ARGF.readlines.map(&:strip).map do |record|
  record.match(PATTERN) do |m|
    coords = %i(id left top width height).each_with_object(Hash.new) do |prop, hash|
      hash[prop] = m[prop].to_i
    end
    (coords[:left]...(coords[:left] + coords[:width])).each do |x|
      (coords[:top]...(coords[:top] + coords[:height])).each do |y|
        grid[x][y] << coords[:id]
      end
    end
    coords
  end
end

part1 = grid.flatten(1).count { |cell| cell.count >= 2 }
puts "Part 1: #{part1}"

part2 = claims.select do |claim|
  claimed_cells = (claim[:left]...(claim[:left] + claim[:width])).to_a.product(
    (claim[:top]...(claim[:top] + claim[:height])).to_a)

  true if claimed_cells.all? { |x,y| grid[x][y].count == 1 }
end

puts "Part 2: #{ part2.map{ |c| c[:id]}.first }"
