moves = ARGF.read.split(', ')
CARDINALS =  { 0 => 'North',
               1 => 'East',
               2 => 'South',
               3 => 'West'
}

class Direction
  def initialize(dir=0)
    if dir.class == String
      @dir = CARDINALS.invert[dir]
    else
      @dir = dir
    end
  end

  def turn direction
    self.send "turn_#{direction.downcase}"
  end

  def turn_r
    @dir += 1
    @dir = 0 if @dir == 4
  end

  def turn_l
    @dir -= 1
    @dir = 3 if @dir == -1
  end

  def to_s
    CARDINALS[@dir]
  end
end

part2_loc = nil
facing = Direction.new
location = [0,0]
seen = [ location.dup ]
moves.each do |move|
  direction = move[0]
  distance = move[1..-1].to_i
  facing.turn direction
  distance.times do |_|
    case facing.to_s
    when 'North' then location[0] -= 1
    when 'East' then location[1] += 1
    when 'South' then location[0] += 1
    when 'West'  then location[1] -= 1
    end
    if seen.include?(location) && part2_loc.nil?
      part2_loc = location.dup
    else
      seen.append location.dup
    end
  end

end

puts "Part 1: #{location.map(&:abs).sum}"

puts "Part 2: #{part2_loc.map(&:abs).sum}"
