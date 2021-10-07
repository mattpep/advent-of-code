require 'set'

module AOC
  class OrbitMap
    class NoPathToNodeError < StandardError; end

    ROOT = 'COM'
    PATTERN = /(?<left>[A-Z0-9]+)\)(?<right>[A-Z0-9]+)/
    attr_accessor :orbits

    def initialize(data)
      self.orbits = Set.new
      data.split.map(&:strip).each do |record|
        record.match(PATTERN) do |m|
          self.orbits << [ m[:left], m[:right] ]
        end
      end
    end

    def path_length_from(from, to)
      at = from
      count = 0
      while at != to
        count += 1
        begin
          at = orbits.select { |x, y| y == at }[0][0]
        rescue NoMethodError
          raise NoPathToNodeError
        end
      end
      count
    end

    def count
      nodes.sum { |x| path_length_from(x, ROOT) }
    end

    private

    def nodes
      orbits.to_a.flatten.uniq
    end

  end
end
