PATTERN = /^(?<before>.*)\((?<inner>(?>[^)(]+|\g<0>)*)\)(?<after>.*)$/

def lr_parse string
  string.match(PATTERN) do |m|
    inner = lr_parse m[:inner]
    return lr_parse("#{m[:before]} #{inner} #{m[:after]}")
  end
  tokens = string.split
  if tokens.count == 1
    return tokens.to_i
  elsif tokens.count == 3
    result = tokens[0].to_i.send(tokens[1].to_sym, tokens[2].to_i)
    return result
  else
    partial = tokens[0].to_i.send(tokens[1].to_sym, tokens[2].to_i)
    result = lr_parse("#{partial} #{tokens[3..-1].join ' '}")
    return result
  end
end

input = ARGF.readlines.map &:strip
part1 = input.map { |line| lr_parse line }.sum
puts "Part 1: #{part1}"
