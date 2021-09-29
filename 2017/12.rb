require 'set'

PATTERN = /(?<prog>\d+) <-> (?<list>\d+(, \d+)*)/
PROGRAMS = ARGF.readlines.each_with_object({}) do |row, hash|
  row.match(PATTERN) do |m|
    hash[m[:prog].to_i] = m[:list].split(', ').map(&:to_i)
  end
end

def discover(start, seen=Set.new)
  subordinates = PROGRAMS[start]
  subordinates.each do |sub|
    next if seen.include? sub
    seen.merge discover(sub, seen+[sub].to_set)
  end
  seen
end

puts "Part 1: #{discover(0).size}"
