module AOC
  class AsteroidField
    class NotAnAsteroidError < StandardError ; end
    ASTEROID = '#'

    attr_accessor :cells

    def initialize(text_input)
      self.cells = text_input.split.map(&:chomp).map(&:chars)
    end

    def visible_from(x,y)
      raise NotAnAsteroidError unless cells[y][x] == ASTEROID
      visibles = []
      (0...height).each do |ypos|
        (0...width).each do |xpos|
          next if x == xpos && y == ypos
          next unless cells[ypos][xpos] == '#'
          asteroids = cells_between([x,y], [xpos,ypos])[1..-1]
                      .select { |location| cells[location[1]][location[0]] == ASTEROID }
          if asteroids.any?
            visibles.append(asteroids.first)
          end
        end
      end
      visibles.uniq
    end

    def best
      (0...height).each_with_object({}) do |ypos, hash|
        (0...width).each do |xpos|
          begin
            hash[[xpos,ypos]] = visible_from(xpos, ypos).count 
          rescue NotAnAsteroidError
          end
        end
      end.max_by { |_, v| v }[0]
    end

    private

    def width
      cells.first.length
    end

    def height
      cells.size
    end

    def cells_between(aster1, aster2)
      neighs = []
      return [] if aster1 == aster2
      cellcount = (aster1[0]-aster2[0]).abs.gcd((aster1[1]-aster2[1]).abs)
      x_direction = cmp(aster1[0], aster2[0])
      y_direction = cmp(aster1[1], aster2[1])
      x_step = (aster1[0]-aster2[0]).abs / cellcount
      y_step = (aster1[1]-aster2[1]).abs / cellcount

      (0..cellcount).each do |offset| 
        new_x = aster1[0]+(offset*x_direction*x_step)
        new_y = aster1[1]+(offset*y_step*y_direction)
        neighs.append [ new_x, new_y ]
      end
      neighs
    end

    def cmp(b,a)
      if a < b
        -1
      elsif a == 0
        0
      else
        1
      end
    end
  end
end
