data = ARGF.readlines.map &:strip

PATTERN = /^(?<lower>[a-z]+) \((?<weight>\d+)\)( -> (?<upper>[a-z, ]+))?$/

towers = data.each_with_object(Hash.new) do |tower, hash|
  tower.match(PATTERN) do |m|
    hash[m[:lower]] = if m[:upper].nil?
                        []
                      else
                        m[:upper].split ', '
                      end
  end
end

part1 = (towers.keys - towers.values.flatten)[0]
puts "Part 1: #{part1}"
