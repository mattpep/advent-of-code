PATTERN = /^(?<before>.*)\((?<inner>(?>[^)(]+|\g<0>)*)\)(?<after>.*)$/

def parse string, mode='lr'
  # strip parentheses
  string.match(PATTERN) do |m|
    inner = parse(m[:inner], mode)
    return parse("#{m[:before]} #{inner} #{m[:after]}", mode)
  end

  tokens = string.split
  if tokens.count == 1
    return tokens.to_i
  elsif tokens.count == 3
    result = tokens[0].to_i.send(tokens[1].to_sym, tokens[2].to_i)
    return result
  else
    if mode == 'lr'
      partial = tokens[0].to_i.send(tokens[1].to_sym, tokens[2].to_i)
      result = parse("#{partial} #{tokens[3..-1].join ' '}", mode)
      return result
    else
      # Let's look for a plus operator, in order to reduce that first
      index = tokens.index('+')
      if index
        left = tokens[0...(index-1)]
        right = tokens[(index+2)..-1]
        partial = tokens[index-1].to_i.send(tokens[index].to_sym, tokens[index+1].to_i)
        result = parse("#{left.join ' '} #{partial} #{right.join ' '}", mode)
        return result
      else
        # We're left with only multiplication
        # (The case of just a single token is handled further up in the `if` clause)
        partial = tokens[0].to_i.send(tokens[1].to_sym, tokens[2].to_i)
        result = parse("#{partial} #{tokens[3..-1].join ' '}", mode)
        return result
      end
    end
  end
end

input = ARGF.readlines.map &:strip
part1 = input.map { |line| parse line, 'lr' }.sum
puts "Part 1: #{part1}"

part2 = input.map { |line| parse line, 'invert' }.sum
puts "Part 2: #{part2}"
