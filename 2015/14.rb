PATTERN = /(?<name>[A-Z][a-z]+) can fly (?<speed>\d+) km\/s for (?<duration>\d+) seconds, but then must rest for (?<rest>\d+) seconds\./

RACE_DURATION = 2503
reindeer = ARGF.readlines.each_with_object({}) do |record, deer|
  record.match(PATTERN) do |m|
    deer[ m[:name] ] = { distance: 0, speed: m[:speed].to_i, dur: m[:duration].to_i, rest: m[:rest].to_i, points: 0 }
  end
end

RACE_DURATION.times do |tick|
  reindeer.each do |name, data|
    segment_duration = tick % ( data[:dur] + data[:rest] )
    if segment_duration < data[:dur]
      reindeer[name][:distance] += data[:speed]
    end
  end

  leader_distance = reindeer.map { |r| r[1][:distance] }.max
  leaders = reindeer.select { |name,data| data[:distance] == leader_distance }.keys
  leaders.each { |r| reindeer[r][:points] += 1 }
end

winner = reindeer.max_by { |r| r[1][:distance]}
puts "Part 1: #{winner[1][:distance]}"

winner = reindeer.max_by { |r| r[1][:points]}
puts "Part 2: #{winner[1][:points]}"
