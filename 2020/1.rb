require 'net/http'

TARGET = 2020

numbers = ARGF.read.split("\n").map(&:to_i)

part1 = numbers.combination(2).select { |a,b| a+b == TARGET }.first.reduce :*

part2 = numbers.combination(3).select { |a,b,c| a+b+c == TARGET }.first.reduce :*

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
