module AOC
  class Seabed
    attr_accessor :heights
    def initialize data
      self.heights = Marshal.load Marshal.dump data
    end

    def lowest_points
      low_points = []
      heights.length.times do |y|
        heights.first.length.times do |x|
          low_points << find_low_point_from(x,y)
          low_points.uniq!
        end
      end
      low_points
    end

    def risk_level
      lowest_points.map do |x,y|
        heights[y][x] + 1
      end.sum
    end

    def find_low_point_from x,y
      while true
        n = neighbours(x,y).min_by { |x,y| heights[y][x] } 

        return [x,y] if heights[n[1]][n[0]] > heights[y][x]
        x,y = n[0],n[1]
      end
    end


    def neighbours x,y
      locations = []
      locations << [x, y-1] if y > 0
      locations << [x, y+1] if y < height.pred
      locations << [x-1, y] if x > 0
      locations << [x+1, y] if x < width.pred
      locations
    end

    def width
      heights.first.length
    end

    def height
      heights.length
    end
  end
end
