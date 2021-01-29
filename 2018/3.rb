PATTERN = /#\d+ @ (?<left>\d+),(?<top>\d+): (?<width>\d+)x(?<height>\d+)/

SIZE = 1000
grid = Array.new(1000) { Array.new(1000) { 0 } }

tiles = ARGF.readlines.map(&:strip).map do |record|
  record.match(PATTERN) do |m|
    coords = %i(left top width height).each_with_object(Hash.new) do |prop, hash|
      hash[prop] = m[prop].to_i
    end
    (coords[:left]...(coords[:left] + coords[:width])).each do |x|
      (coords[:top]...(coords[:top] + coords[:height])).each do |y|
        grid[x][y] += 1
      end
    end
  end
end

part1 = grid.flatten.count { |cell| cell >= 2 }

puts "Part 1: #{part1}"
