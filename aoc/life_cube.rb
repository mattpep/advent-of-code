module AOC
  class LifeCube
    OCCUPIED = '#'
    EMPTY = '.'

    attr_reader :expanding
    attr_accessor :cells

    def initialize expanding=false
      @expanding = expanding
      @cells = []
    end

    def population
      cells.flatten.count { |value| value == OCCUPIED }
    end

    def tick
      expand if expanding
      new_cells = Marshal.load( Marshal.dump(cells) )
      (0...width).each do |x|
        (0...depth).each do |y|
          (0...height).each do |z|
            occupied_neighbours = neighbour_cells(x,y,z).count { |z,y,x| cells[z][y][x] == OCCUPIED }
            case occupied_neighbours
            when 2
              new_cells[z][y][x] = cells[z][y][x]
            when 3
              new_cells[z][y][x] = OCCUPIED
            else
              new_cells[z][y][x] = EMPTY
            end

          end
        end
      end
      cells.replace Marshal.load( Marshal.dump(new_cells) )
    end

    def expand
      expand_up if cells[-1].flatten.any? { |cell| cell == OCCUPIED }
      expand_down if cells[0].flatten.any? { |cell| cell == OCCUPIED }
      expand_left if cells.any? do |layer|
        layer.any? { |row| row[0] == OCCUPIED }
      end
      expand_right if cells.any? do |layer|
        layer.any? { |row| row[-1] == OCCUPIED }
      end
      expand_front if cells.any? do |layer|
        layer[0].any? { |front_cell| front_cell == OCCUPIED }
      end
      expand_back if cells.any? do |layer|
        layer[-1].any? { |back_cell| back_cell == OCCUPIED }
      end
    end

    def expand_up
      layer = Array.new(depth) { Array.new(width) { EMPTY } }
      cells << layer
    end

    def expand_down
      layer = Array.new(depth) { Array.new(width) { EMPTY } }
      cells.prepend layer
    end

    def expand_left
      cells.each do |layer|
        layer.each do |row|
          row.prepend EMPTY
        end
      end
    end

    def expand_right
      cells.each do |layer|
        layer.each do |row|
          row << EMPTY
        end
      end
    end

    def expand_back
      cells.each do |layer|
        layer << Array.new(width) { EMPTY }
      end
    end

    def expand_front
      cells.each do |layer|
        layer.prepend Array.new(width) { EMPTY }
      end
    end

    private

    def neighbour_cells(x, y, z)
      (([0,z-1].max)...[z+2,height].min).to_a.product(
        (([0,y-1].max)...[y+2,depth].min).to_a).product(
          (([0,x-1].max)...[x+2,width].min).to_a).map(&:flatten).reject { |me| me == [z,y,x] }
    end

    def height
      cells.size
    end

    def depth
      cells[0].size
    end

    def width
      cells[0][0].size
    end
  end
end
