require 'set'

moves = ARGF.readlines.map(&:strip).map do |m|
  dir = m.split.first
  dist = m.split.last.to_i
  { dir: dir, dist: dist }
end

# 0,0 is topleft
location = {x: 0, y: 0}
locations = []
extremities = {minx: 0, miny: 0, maxx: 0, maxy: 0}

# calculate the grid extremities
moves.each do |move|
  case move[:dir]
  when 'R'
    location[:x] += move[:dist]
    if extremities[:maxx] < location[:x]
      extremities[:maxx] = location[:x]
    end

  when 'L'
    location[:x] -= move[:dist]
    if extremities[:minx] > location[:x]
      extremities[:minx] = location[:x]
    end

  when 'U'
    location[:y] -= move[:dist]
    if extremities[:miny] > location[:y]
      extremities[:miny] = location[:y]
    end

  when 'D'
    location[:y] += move[:dist]
    if extremities[:maxy] < location[:y]
      extremities[:maxy] = location[:y]
    end

  else
    puts "parsefail"
    exit
  end
  locations << {x: location[:x], y: location[:y]}
end

# normalise the locations
x_offset = 0 - extremities[:minx]
y_offset = 0 - extremities[:miny]
locations.each_with_index do |loc, idx|
  # puts "normalising #{idx}: currently #{loc}, with offsets x:#{x_offset}, y:#{y_offset}"
  locations[idx][:x] = loc[:x] + x_offset
  locations[idx][:y] = loc[:y] + y_offset
  # puts "Normalised location is : #{locations[idx].inspect}"
end


class RopeBridge
  attr_reader :visits, :size
  EMPTY = '.'
  HEAD = 'H'
  TAIL = 'T'
  BOTH = 'X'
  START = 's'
  SEEN = '#'

  def initialize(size_x, size_y)
    # @grid = Array.new(size_y) { Array.new(size_x) { EMPTY } }
    @size = { x: size_x, y: size_y }
    @visits = Set.new
    @head_x = 0
    @head_y = 0
    @tail_x = 0
    @tail_y = 0
    # @grid[@head_y][@head_x] = HEAD
    @visits << [@tail_x, @tail_y]
  end

  def dump_grid
    # puts "\e1;" # Move to top left
    (0...size[:y]).to_a.reverse.each do |row|
      r = (0...size[:x]).to_a.map do |col|
        if @head_x == col && @head_y == row && @tail_x == col && @tail_y == row
          BOTH
        elsif @tail_x == col && @tail_y == row
          TAIL
        elsif @head_x == col && @head_y == row
          HEAD
        elsif col == 0 && row == 0
          START
        elsif @visits.include? [col,row]
          SEEN
        else
          EMPTY
        end
      end.join
      puts r
    end

    puts "Head is at #{[@head_x, @head_y]}, tail is at #{[@tail_x, @tail_y]}\n"
  end

  def move(mov)
    # puts "======== Move: #{mov}"
    mov[:dist].times do |x|
      # puts "- - - - - - - - - - - -"
      # move head
      case mov[:dir]
      when 'D'
        @head_y -= 1
      when 'U'
        @head_y += 1
      when 'L'
        @head_x -= 1
      when 'R'
        @head_x += 1
      end

      # puts "moved head but not tail:"
      # dump_grid
      # puts "(maybe) moving tail"
      # (maybe) move tail

      # co-located
      if @head_x == @tail_x && @head_y == @tail_y
        # puts "colocated"
        # nothing to do

      # Horizontally adjacent
      elsif @head_y == @tail_y && (@head_x-@tail_x).abs == 1
        # puts "horiz adj"
        # nothing to do

      # Vertically adjacent
      elsif @head_x == @tail_x && (@head_y-@tail_y).abs == 1
        # puts "vert adj"
        # nothing to do

      # same row but two apart
      elsif @head_y == @tail_y && (@head_x-@tail_x).abs == 2
        # puts "same row, 2 apart"
        if @head_x > @tail_x
          @tail_x += 1
        else
          @tail_x -= 1
        end

      # same column but two apart
      elsif @head_x == @tail_x && (@head_y-@tail_y).abs == 2
        # puts "same col, 2 apart"
        if @head_y > @tail_y
          @tail_y += 1
        else
          @tail_y -= 1
        end
        #

      # diagonal separation but adjacent
      elsif (@head_y - @tail_y).abs == 1 && (@head_x-@tail_x).abs == 1
        # puts "diag adj"
        # nothing to do

      # is a knight's move away (8 possibilities, but we can split these into 4 pairs based on the move needed for the tail)
      else
        # puts "knight move apart"
        if @head_x > @tail_x && @head_y > @tail_y
          @tail_x += 1
          @tail_y += 1
        elsif @head_x > @tail_x && @head_y < @tail_y
          @tail_x += 1
          @tail_y -= 1
        elsif @head_x < @tail_x && @head_y < @tail_y
          @tail_x -= 1
          @tail_y -= 1
        elsif @head_x < @tail_x && @head_y > @tail_y
          @tail_x -= 1
          @tail_y += 1
        end
      end
      # puts "moved tail"
      # dump_grid
      @visits << [@tail_x, @tail_y]
    end
  end
end

bridge = RopeBridge.new(extremities[:maxx]-extremities[:minx], extremities[:maxy]-extremities[:miny])
moves.each { |move| bridge.move move }

part1 = bridge.visits.count
puts "Part 1 (visited squares): #{part1}"
