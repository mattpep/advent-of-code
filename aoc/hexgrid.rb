module AOC
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
    # See https://www.redblobgames.com/grids/hexagons/ for details
    
    attr_accessor :grid

    def initialize size, value=nil
      @grid = Array.new(size) { Array.new(size) { value } }
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
