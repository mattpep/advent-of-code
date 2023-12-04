# frozen_string_literal: true

games = ARGF.readlines.map(&:strip).each_with_object({}) do |row, hash|
  parts = row.split(': ')
  id = parts[0].split[1].to_i
  hands = parts[1].split('; ').map do |hand|
    hand.split(', ').each_with_object({}) do |color, hsh|
      count_colour = color.split
      hsh[count_colour[1]] = count_colour[0].to_i
    end
  end
  hash[id] = hands
end

CONSTRAINT = {
  red: 12,
  green: 13,
  blue: 14
}.freeze

def hand_possible?(hand, constraint)
  hand.all? { |color, hand_count| hand_count <= constraint[color.to_sym] }
end

def game_possible?(game, constraint)
  game.all? { |hand| hand_possible?(hand, constraint) }
end

def game_power(game)
  CONSTRAINT.keys.map do |color|
    game.map { |h| h[color.to_s].to_i }.max
  end.reduce(:*)
end

part1 = games.sum do |id, game|
  if game_possible?(game, CONSTRAINT)
    id
  else
    0
  end
end

puts "Part 1: #{part1}"

part2 = games.sum do |_, game|
  game_power(game)
end
puts "Part 2: #{part2}"
