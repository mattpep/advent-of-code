groups = ARGF.read.split("\n\n").map { |group| group.split("\n") }

puts "Part 1: #{groups.map { |g| g.join.chars.uniq.count }.sum}"


questions = groups.join.chars.sort.uniq
part2 = groups.sum do |group|
  questions.count do |question|
    group.all? { |person| person.chars.include? question }
  end
end

puts "Part 2: #{part2}"
