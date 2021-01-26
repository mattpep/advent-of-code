module AOC

  # Used in 2015:18
  class LifeGrid
    OCCUPIED = '#'
    EMPTY = '.'

    attr_reader :expanding
    attr_accessor :cells

    def initialize size: 0, expanding: false
      @expanding = expanding
      @cells = size.zero? ? [] : Array.new(size) { Array.new(size) { EMPTY } }
    end

    def population
      cells.flatten.count { |value| value == OCCUPIED }
    end

    def tick
      expand if expanding
      new_cells = Marshal.load( Marshal.dump(cells) )
      (0...width).each do |x|
        (0...height).each do |y|
          occupied_neighbours = neighbour_cells(x,y).count { |y,x| cells[y][x] == OCCUPIED }
          case occupied_neighbours
          when 2
            new_cells[y][x] = cells[y][x]
          when 3
            new_cells[y][x] = OCCUPIED
          else
            new_cells[y][x] = EMPTY
          end
        end
      end
      cells.replace Marshal.load( Marshal.dump(new_cells) )
    end

    def expand
      expand_up if cells[-1].any? { |cell| cell == OCCUPIED }
      expand_down if cells[0].any? { |cell| cell == OCCUPIED }
      expand_left if cells.any? do |column|
        column.any? { |cell| cell == OCCUPIED }
      end
      expand_right if cells.any? do |column|
        column.any? { |cell| cell == OCCUPIED }
      end
    end

    def expand_up
      row = Array.new(width) { EMPTY }
      cells << layer
    end

    def expand_down
      row = Array.new(width) { EMPTY }
      cells.prepend row
    end

    def expand_left
      cells.each { |column| column.prepend EMPTY }
    end

    def expand_right
      cells.each { |column| column << EMPTY }
    end

    private

    def neighbour_cells(x, y)
      (([0,y-1].max)...[y+2,height].min).to_a.product(
        (([0,x-1].max)...[x+2,width].min).to_a).reject { |me| me == [y,x] }
    end

    def height
      cells.size
    end

    def width
      cells[0].size
    end
  end
end
