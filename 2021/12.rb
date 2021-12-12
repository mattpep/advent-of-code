edges = ARGF.readlines.map do |line|
  line.strip.split '-'
end

def generate_paths edges, path, permissive=false
  possibles = edges.select { |a, _| a == path.last }.map &:last
  possibles += edges.select { |_, b| b == path.last }.map &:first

  possibles.each do |possible|
    if possible == 'end'
      yield(path + [possible])
      next
    elsif possible == 'start'
      next
    elsif possible == possible.downcase && path.include?(possible)
      next unless permissive

      # We can visit this cave again only if there are no other small caves visited twice
      next if (path - ['start']).select { |cave| cave == cave.downcase }.any? do |cave|
        path.count(cave) == 2
      end
    end
    generate_paths(edges, path + [possible], permissive) do |path|
      yield path
    end
  end
end

paths = Array.new
generate_paths(edges, ['start']) do |path|
  paths << path
end

puts "Part 1: #{paths.count}"

paths = Array.new
generate_paths(edges, ['start'], true) do |path|
  paths << path
end

puts "Part 2: #{paths.count}"
