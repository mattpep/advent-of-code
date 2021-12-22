throw_count = 0
player1 = { score: 0, position: 4 }
player2 = { score: 0, position: 7 }

dface = 0
while true
  turn_score = 0
  3.times do
    dface += 1
    dface %= 100
    turn_score += dface
  end
  throw_count += 3
  player1[:position] += turn_score
  player1[:position] %= 10
  player1[:position] = 10 if player1[:position] == 0
  player1[:score] += player1[:position]

  break if player1[:score] >= 1000

  turn_score = 0
  3.times do
    dface += 1
    dface %= 100
    turn_score += dface
  end
  throw_count += 3
  player2[:position] += turn_score
  player2[:position] %= 10
  player2[:position] = 10 if player2[:position] == 0
  player2[:score] += player2[:position]

  break if player2[:score] >= 1000
end

part1 = throw_count * [player1[:score], player2[:score]].min

puts "Part 1: #{part1}"
