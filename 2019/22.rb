operations = ARGF.readlines.map &:strip

DECKSIZE = 10007
PATTERN = /(?<operation>(deal with increment)|(deal into new stack)|(cut))( (?<value>-?\d+))?$/
TARGET_CARD = 2019

deck = (0...DECKSIZE).to_a

def deal_n deck_in, increment
  result = [nil] * DECKSIZE
  ptr ||= 0
  deck_in.each do |card|
    result[ptr] = card
    ptr += increment
    ptr %= DECKSIZE
  end
  result
end

operations.each do |op|
  op.match(PATTERN) do |m|
    value = m[:value].to_i if m[:value]
    case m[:operation]
    when 'deal into new stack'
      deck.reverse!
    when 'deal with increment'
      deck.replace deal_n(deck, value)
    when 'cut'
      if value.negative?
        deck.replace(deck[value..-1] + deck[0...value] )
      else
        deck.replace(deck[value..-1] + deck[0...value])
      end
    end
  end or raise StandardError, "Did not match! text was >#{op}<"
end

# puts "After all opeations the order is #{deck.inspect}"

puts "Part 1: #{ deck.index(TARGET_CARD) }"
