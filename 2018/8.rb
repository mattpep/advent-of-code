require_relative '../aoc/meta_tree'

data = ARGF.readlines.map(&:strip).map(&:split).flatten.map(&:to_i)

top = AOC::MetaTree.new data
puts "Part 1: #{top.metasum}"


puts "Part 2: #{top.value}"
