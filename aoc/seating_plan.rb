require_relative 'life_grid'
require 'ansi'

module AOC
  # used in 2020:11
  class SeatingPlan < LifeGrid
    OCCUPIED = '#'
    FLOOR = '.'
    EMPTYSEAT = 'L'

    NEAR = 1
    FAR = 99

    FUSSY = 4
    TOLERANT = 5

    attr_accessor :changed, :epoch

    def initialize(data, tolerance = FUSSY, visibility = NEAR)
      y = data.size
      x = data[0].size
      @changed = nil
      @tolerance = tolerance
      @visibility = visibility
      @epoch = 0
      @cells = Array.new(y) { Array.new(x) { FLOOR } }
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
          occupied_neighbours = neighbour_cells(x,y).select { |y,x| cells[y][x] == OCCUPIED }.size

          if cells[y][x] == EMPTYSEAT && occupied_neighbours == 0
            new_cells[y][x] = OCCUPIED
            self.changed = true
          elsif cells[y][x] == OCCUPIED && occupied_neighbours >= @tolerance
            new_cells[y][x] = EMPTYSEAT
            self.changed = true
          elsif cells[y][x] == FLOOR
            new_cells[y][x] = FLOOR
          else
            new_cells[y][x] = cells[y][x]
          end
        end
      end
      cells.replace Marshal.load( Marshal.dump(new_cells) )
    end

    def neighbour_cells(x, y)
      if @visibility == NEAR
        super
      else
        neighbours = []

        (y-1).downto(0) do |y|# up
          if !cells[y][x].nil? && cells[y][x] != FLOOR
            neighbours.append([y, x])
            break
          end
        end

        (y+1).upto(height-1) do |y| # down
          if !cells[y][x].nil? && cells[y][x] != FLOOR
            neighbours.append([y, x])
            break
          end
        end

        (x+1).upto(width-1) do |x| # right
          if !cells[y][x].nil? && cells[y][x] != FLOOR
            neighbours.append([y, x])
            break
          end
        end

        (x-1).downto(0) do |x| # left
          if !cells[y][x].nil? && cells[y][x] != FLOOR
            neighbours.append([y, x])
            break
          end
        end

        distance = 1 # NE
        while true
          break if y-distance < 0 || x+distance+1 > width
          if !cells[y-distance][x+distance].nil? && cells[y-distance][x+distance] != FLOOR
            neighbours.append([y-distance, x+distance])
            break
          end
          distance += 1
        end

        distance = 1 # SE
        while true
          break if y+distance+1 > height || x+distance+1 > width
          if !cells[y+distance][x+distance].nil? && cells[y+distance][x+distance] != FLOOR
            neighbours.append([y+distance, x+distance])
            break
          end
          distance += 1
        end

        distance = 1 # NW
        while true
          break if y-distance < 0 || x-distance < 0
          if !cells[y-distance][x-distance].nil? && cells[y-distance][x-distance] != FLOOR
            neighbours.append([y-distance, x-distance])
            break
          end
          distance += 1
        end

        distance = 1
        while true
          break if y+distance+1 > height || x-distance < 0
          if !cells[y+distance][x-distance].nil? && cells[y+distance][x-distance] != FLOOR
            neighbours.append([y+distance, x-distance])
            break
          end
          distance += 1
        end

        neighbours.uniq.reject { |me| me == [y,x] }
      end
    end
  end
end
