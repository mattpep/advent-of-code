data = ARGF.read.split("\n\n").map { |chunk| chunk.split "\n" }

player1, player2 = data.map do |chunk|
  chunk[1..-1].map &:to_i
end

while true
  break if player1.empty? || player2.empty?
  card1 = player1.delete_at 0
  card2 = player2.delete_at 0
  if card1 > card2
    player1 += [card1, card2]
  else
    player2 += [card2, card1]
  end
end

score = (player1 + player2).reverse.each_with_index.map do |card, index|
  card * (index + 1)
end.sum

puts "Part1: #{score}"
