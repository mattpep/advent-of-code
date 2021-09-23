require_relative 'life_grid'

module AOC
  # used in 2020:11
  class SeatingPlan < LifeGrid
    OCCUPIED = '#'
    FLOOR = '.'
    EMPTYSEAT = 'L'

    attr_accessor :changed, :epoch

    def initialize(data)
      x = data.size
      y = data[0].size
      @changed = nil
      @epoch = 0
      @cells = Array.new(x) { Array.new(y) { FLOOR } }
      data.each_with_index do |row, y|
        row.chars.each_with_index do |cell, x|
          @cells[y][x] = cell
        end
      end
    end

    def tick
      self.epoch += 1
      self.changed = false
      expand if expanding
      new_cells = Marshal.load( Marshal.dump(cells) )
      (0...height).each do |y|
        (0...width).each do |x|
          occupied_neighbours = neighbour_cells(x,y).count { |x,y| cells[x][y] == OCCUPIED }

          if cells[y][x] == EMPTYSEAT && occupied_neighbours == 0
            new_cells[y][x] = OCCUPIED
            self.changed = true
          elsif cells[y][x] == OCCUPIED && occupied_neighbours >= 4
            new_cells[y][x] = EMPTYSEAT
            self.changed = true
          elsif cells[y][x] == FLOOR
            new_cells[y][x] = FLOOR
          end
        end
      end
      cells.replace Marshal.load( Marshal.dump(new_cells) )
    end
  end
end
