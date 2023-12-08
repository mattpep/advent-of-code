PATTERN = /(?<name>[A-Z][a-z]+) would (?<gain_lose>gain|lose) (?<units>\d+) happiness units by sitting next to (?<neighbour>[A-Z][a-z]+)\./

data = ARGF.readlines.map &:strip

rules = data.each_with_object({}) do |line,record|
  line.match(PATTERN) do |m|
    record[m[:name]] = [] if record[m[:name]].nil?
    record[m[:name]] << {
      change: 0.send( m[:gain_lose] == 'gain' ? :+ : :-, m[:units].to_i),
      neighbour: m[:neighbour]
    }
  end
end

def score arrangement, rules
  s = 0

  (0..(arrangement.size-1)).each do |middle_seat_number|
    left_idx = if middle_seat_number == 0
             arrangement.size - 1
           else
              middle_seat_number - 1
           end
    right_idx = if middle_seat_number == arrangement.size - 1
              0
           else
              middle_seat_number + 1
           end
    middle_name = arrangement[middle_seat_number]
    left_name = arrangement[left_idx]
    right_name = arrangement[right_idx]

    left_rule = rules[middle_name].select { |r| r[:neighbour] == left_name }.first
    right_rule = rules[middle_name].select { |r| r[:neighbour] == right_name }.first

    s += left_rule[:change]
    s += right_rule[:change]
  end
  s
end

names = rules.keys
part1 = names.permutation.map do |perm|
  score(perm, rules)
end.max

puts "Part 1: #{part1}"

names << 'Me'
rules['Me'] = []
names.each do |name|
  next if name == 'Me'
  rules['Me'] << { change: 0, neighbour: name }
  rules[name] << { change: 0, neighbour: 'Me' }
end

part2 = names.permutation.map do |perm|
  score(perm, rules)
end.max

puts "Part 2: #{part2}"
