module AOC
  class MoonSystem
    PATTERN = /^<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/

    attr_accessor :moons

    def initialize(moon_data)
      @moons = moon_data.map do |record|
        record.match(PATTERN) do |m|
          {
            pos: {
              x: m[:x].to_i,
              y: m[:y].to_i,
              z: m[:z].to_i,
            },

            vel: { x: 0, y: 0, z: 0 }
          }
        end
      end
    end

    def energy
      moons.sum do |moon|
        kinetic = moon[:vel].map { |_,value| value.abs }.sum 
        potential = moon[:pos].map { |_,value| value.abs }.sum
        kinetic * potential
      end
    end

    def step
      # apply gravity: compare positions and adjust velocity
      moons.combination(2).each do |moon_pair|
        %i[ x y z ].each do |axis|
          if moon_pair[0][:pos][axis] > moon_pair[1][:pos][axis]
            moon_pair[0][:vel][axis] -= 1
            moon_pair[1][:vel][axis] += 1
          elsif moon_pair[0][:pos][axis] < moon_pair[1][:pos][axis]
            moon_pair[0][:vel][axis] += 1
            moon_pair[1][:vel][axis] -= 1
          else
            # no change
          end
        end
      end

      # apply velocity: adjust positions
      moons.each do |moon|
        %i[ x y z ].each do |axis|
          moon[:pos][axis] += moon[:vel][axis]
        end
      end
    end
  end
end
