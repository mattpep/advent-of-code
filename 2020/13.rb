start_time = ARGF.readline.strip.to_i
bus_ids = ARGF.readline.strip.split(',').map(&:to_i).reject &:zero?

wait = 0

def check_buses_present bus_ids, timestamp
  bus_ids.each do |id|
    return id if timestamp % id == 0
  end
  nil
end

id = nil
until id
  wait += 1
  id = check_buses_present bus_ids, start_time + wait
end

puts "Part 1: #{ id * wait }"
