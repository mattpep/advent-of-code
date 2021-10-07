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
      path_from(from, to).length
    end

    def path_from(from, to)
      at = from
      path = []
      while at != to
        path << at
        begin
          at = orbits.select { |x, y| y == at }[0][0]
        rescue NoMethodError
          raise NoPathToNodeError
        end
      end
      path
    end

    def count_orbits
      nodes.sum { |x| path_length_from(x, ROOT) }
    end

    def count_transfers_from(from, to)
      csn = closest_shared_node(from,to)
      length1 = path_length_from(from, csn) - 1
      length2 = path_length_from(to, csn) - 1
      return length1 + length2
    end

    private

    def nodes
      orbits.to_a.flatten.uniq
    end

    def closest_shared_node(a, b)
      leg1 = path_from(a, ROOT)
      leg2 = path_from(b, ROOT)
      leg1.select do |node|
        leg2.include? node
      end.first
    end


  end
end
