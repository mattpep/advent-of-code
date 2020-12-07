require 'set'

CONTAINING_PATTERN = /^(?<container>[a-z]+ [a-z]+) bags contain (?<content>(no other bags)|(((\d+ [a-z]+ [a-z]+) bags?)(, )?)+)\.$/
BAG_PATTERN = /(?<qty>\d+) (?<adjective>[a-z]+) (?<color>[a-z]+) bags?/

records = ARGF.readlines.map(&:strip)
bag_data = Hash.new

records.each do |record|
  # puts "Looking at record: #{record}"
  record.match(CONTAINING_PATTERN) do |m|
    if m
      content = m[:content].delete('.')
      bag_data[m[:container]] = Array.new
      unless content == 'no other bags'
        bag_data[m[:container]] = content.split(', ').map do |c|
          c.match(BAG_PATTERN) do |c2|
            [ c2[:qty].to_i, "#{c2[:adjective]} #{c2[:color]}" ]
          end
        end
      end
    end
  end
end

containers = Set.new

old_container_count = containers.count
bag_data.each do |k,v|
  if v.map(&:last).include? "shiny gold"
    containers << k
  end
end

while containers.count > old_container_count
  old_container_count = containers.count
  bag_data.each do |k,v|
    (containers & v.map(&:last) ).each do |new_container|
      containers << k
    end
  end
end

puts "Part 1: possible containers = #{containers.count}"
