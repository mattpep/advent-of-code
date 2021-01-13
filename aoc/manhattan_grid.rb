module AOC
  class ManhattanGrid
    attr_accessor :cur_x, :cur_y, :grid

    def initialize
      @grid = [ [1]  ]
      home!
    end

    def home!
      self.cur_x = 0
      self.cur_y = 0
    end

    def walk path, &block
      path.each do |m|
        move m
        yield self if block_given?
      end
    end

    def current_cell
      grid[cur_y][cur_x]
    end

    def current_cell= val
      grid[cur_y][cur_x] = val
    end

    def move(direction)
      case direction
      when '>' then self.cur_x += 1
      when '<' then self.cur_x -= 1
      when '^' then self.cur_y -= 1
      when 'v' then self.cur_y += 1
      end
      check_bounds
    end

    private

    def debug(message)
      puts "--- #{message} ---"
      puts "current position: #{cur_x}, #{cur_y}"
      grid.each { |row| puts "row: #{row.inspect}" }
      puts
      puts
    end

    def check_bounds
      grid.each { |row| row << 0 } if (cur_x + 1) > grid.first.size  # right
      if cur_x < 0                                                   # left
        grid.each { |row| row.insert(0,0) }
        self.cur_x = 0
      end
      new_row = [0] * grid.first.size
      grid << new_row if (cur_y + 1) > grid.size                     # down
      if cur_y < 0                                                   # up
        grid.insert(0, new_row)
        self.cur_y = 0
      end
    end
  end
end
