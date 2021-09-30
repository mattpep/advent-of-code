require 'set'

module AOC
  # used in 2020:24
  class HexGrid
    # There are 4 ways of arranging a hexgrid if one treats it as isomorphic to
    # a square grid.
    #
    # The first two ways are with the orthogonal move being East and West, with
    # either of odd or even columns being the diagonal offsets.  The second two
    # have North and South as the orthogonal moves, and odd (or even) rows
    # being the diagonal offsets.
    #
    # This implementation uses orthogonal rows, so the six available moves are
    # E, W, NE, SE, NW, and SW.
    #
    # Top left cell is [0,0]
    #
    # See https://www.redblobgames.com/grids/hexagons/ for details

    attr_accessor :grid, :alt_grid

    def initialize size, value=nil
      @grid = Array.new(size) { Array.new(size) { value } }
      @alt_grid = nil
    end

    def prepare_move(location, value)
      if alt_grid.nil?
        self.alt_grid = Marshal.load(Marshal.dump grid)
      end
      alt_grid[location[1]][location[0]] = value
    end

    def commit_prepared_moves!
      return if @alt_grid.nil?
      self.grid = Marshal.load(Marshal.dump @alt_grid)
    end

    def [](index)
      grid[index]
    end

    def []=(index, value)
      grid[index] = value
    end

    def count item
      grid.flatten.count item
    end

    def neighbours_of(cell)
      neighbours = Set[]

      # same row
      if cell[0] > 0
        neighbours << {same: [cell[0]-1, cell[1]] } # W
      end

      if cell[0] < grid.size - 1
        neighbours << {same: [cell[0]+1, cell[1]] } # E
      end

      # row above
      if cell[1] > 0 # top of grid has no rows above
        if cell[1].even? # in even rows NW is the prev column, NE is the same column
          if cell[0] > 0
            neighbours << {above: [cell[0]-1, cell[1]-1] } # NW
          end
          neighbours << {above: [cell[0], cell[1]-1] } # NE
        else # in odd rows NW is the same column, NE is the prev column
          neighbours << {above: [cell[0], cell[1]-1]} # NW
          if cell[0] < grid.size - 1
            neighbours << {above: [cell[0]+1, cell[1]-1]} # NE
          end
        end
      end

      # row below
      if cell[1] < grid.size - 1 # bottom of grid has no rows below
        if cell[1].even? # in even rows SW is the same column, SE is the next column
          if cell[0] > 0
            neighbours << {below: [cell[0]-1, cell[1]+1]} # SW
          end
          neighbours << {below: [cell[0], cell[1]+1] }# SE
        else # in odd rows SW is the prev column, SE is the same column
          neighbours << {below: [cell[0], cell[1]+1] } # SW
          if cell[0] < grid.size - 1
            neighbours << {below: [cell[0]+1, cell[1]+1] }# SE
          end
        end
      end

      neighbours
    end

    def walk_path origin, path
      x, y = origin
      path.each do |move|
        case move
        when 'e'
          x += 1
        when 'w'
          x -= 1
        when 'se'
          x += 1 if y.odd?
          y += 1
        when 'sw'
          x -= 1 if y.even?
          y += 1
        when 'nw'
          x-= 1 if y.even?
          y-= 1
        when 'ne'
          x += 1 if y.odd?
          y -= 1
        end
      end
      [x, y]
    end
  end
end
