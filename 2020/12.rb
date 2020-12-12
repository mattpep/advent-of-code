moves = ARGF.read.split("\n")
CARDINALS =  { 0 => 'North',
               1 => 'East',
               2 => 'South',
               3 => 'West'
}


class Sleigh
  attr_accessor :dir, :location

  def initialize(dir='East')
    @location = [0, 0]
    if dir.class == String
      @dir = CARDINALS.invert[dir]
    else
      @dir = dir
    end
  end

  def move move_info
    action = move_info[0]
    value = move_info[1..-1].to_i

    if action == 'L' || action == 'R'
      (value/90).times { turn action }
    end

    if action == 'N' || CARDINALS[dir] == 'North' && action == 'F'
      location[0] -= value

    elsif action == 'E' || CARDINALS[dir] == 'East' && action == 'F'
      location[1] += value

    elsif action == 'S' || CARDINALS[dir] == 'South' && action == 'F'
      location[0] += value

    elsif action == 'W' || CARDINALS[dir] == 'West' && action == 'F'
      location[1] -= value
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

end

sleigh = Sleigh.new
moves.each { |move| sleigh.move move }

puts "Part 1: #{sleigh.location.map(&:abs).sum}"
