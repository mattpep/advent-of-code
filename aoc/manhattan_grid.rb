module AOC
  class ManhattanGrid
    def initialize(moves)
      @grid = [ [1]  ]
      @cur_x = 0
      @cur_y = 0
      moves.each { |m| move m }
    end

    def visited_houses
      @grid.sum do |row|
        row.filter { |cell| cell != 0 }.count
      end
    end

    def move(direction)
      case direction
      when '>' then @cur_x += 1
      when '<' then @cur_x -= 1
      when '^' then @cur_y -= 1
      when 'v' then @cur_y += 1
      end
      check_bounds
      @grid[@cur_y][@cur_x]+=1
    end

    private

    def debug(message)
      puts "--- #{message} ---"
      puts "current position: #{@cur_x}, #{@cur_y}"
      @grid.each { |row| puts "row: #{row.inspect}" }
      puts
      puts
    end

    def check_bounds
      @grid.each { |row| row << 0 } if (@cur_x + 1) > @grid.first.size  # right
      if @cur_x < 0                                                     # left
        @grid.each { |row| row.insert(0,0) }
        @cur_x = 0
      end
      new_row = [0] * @grid.first.size
      @grid << new_row if (@cur_y + 1) > @grid.size                     # down
      if @cur_y < 0                                                     # up
        @grid.insert(0, new_row)
        @cur_y = 0
      end
    end
  end
end
