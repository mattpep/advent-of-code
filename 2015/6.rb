input = ARGF.readlines.map(&:strip)
SIZE = 1000
PATTERN = /^(?<operation>(turn (on|off))|(toggle)) (?<left>\d+),(?<top>\d+) through (?<right>\d+),(?<bottom>\d+)$/

grid = Array.new(SIZE) { Array.new(SIZE, false) }

input.each_with_object(grid) do |record, grid|
  record.match(PATTERN) do |m|
    left, top, right, bottom = %i[left top right bottom].map { |x| m[x].to_i }
    # puts "DBG: #{m[:operation]} between #{[left, top]} and #{[right, bottom]}"
    (top..bottom).each do |row|
      (left..right).each do |col|
        case m[:operation]
        when 'turn on' then grid[row][col] = true
        when 'turn off' then grid[row][col] = false
        when 'toggle' then grid[row][col] = !grid[row][col]
        end
      end
    end
  end
end

puts "Part 1: #{grid.flatten.filter{|x| x}.count}"
