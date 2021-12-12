edges = ARGF.readlines.map do |line|
  line.strip.split '-'
end

def generate_paths edges, path
  possibles = edges.select { |a, _| a == path.last }.map &:last
  possibles += edges.select { |_, b| b == path.last }.map &:first

  possibles.each do |possible|
    if possible == 'end'
      yield(path + [possible])
      next
    elsif possible == 'start'
      next
    elsif possible == possible.downcase && path.include?(possible)
      next
    end
    generate_paths(edges, path + [possible]) do |path|
      yield path
    end
  end
end

paths = Array.new
generate_paths(edges, ['start']) do |path|
  paths << path
end

puts "Part 1: #{paths.count}"
