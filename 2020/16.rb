chunks = ARGF.read.split("\n\n").map { |chunk| chunk.split("\n") }

fields = chunks[0].each_with_object({}) do |line, hash|
  field = line.split(':')[0]
  ranges = line.split(':')[1].split.values_at(0, 2).map do |range|
    bounds = range.split('-').map &:to_i
    (bounds[0]..bounds[1])
  end
  hash[field] = ranges
end

my_ticket = chunks[1][1].split(',').map &:to_i
nearby_tickets = chunks[2][1..-1].map { |ticket| ticket.split(',').map &:to_i }

def invalid_field_sum ticket, constraints
  ticket.select do |field|
    !constraints.any? { |constraint| constraint.any? { |c| c.include? field } }
  end.sum
end

ticket_scanning_error_rate = nearby_tickets.sum { |ticket| invalid_field_sum ticket, fields.values }
puts "Part 1: #{ticket_scanning_error_rate}"
