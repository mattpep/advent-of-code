nodes = ARGF.readlines.map(&:strip)

CONNECTION = /(?<from>[^-]+) -> (?<to>[a-z]+)/
DEBUG = false

circuit1 = nodes.each_with_object({}) do |node, hash|
  node.match(CONNECTION) do |m|
    hash[m[:to]] = m[:from]
  end
end

def evaluate input, circuit, depth=0
  # a = 999
  puts "#{' ' * depth }evaluting #{input}, the circuit says it is #{circuit[input].inspect}" if DEBUG
  tokens = input.split
  if tokens.count == 1
    puts "#{' ' * depth}Single token found: #{tokens.inspect}, type is #{tokens.first.class}" if DEBUG
    if circuit[input].is_a? Integer
      puts "#{' ' * depth }Found already-cached integer result for #{input.inspect}: #{circuit[input]}" if DEBUG
      return circuit[input] 
    end
    if tokens[0] =~ /^[a-z]+$/
      b = evaluate(circuit[input], circuit, depth+1)
      puts "#{' '*depth}caching result for #{input.inspect}: #{b}" if DEBUG
      circuit[input] = b
      return b
    end
    return tokens[0].to_i
  elsif tokens[0] == 'NOT'
    a = evaluate(tokens[1], circuit, depth+1).to_s(2).tr('01','10').to_i(2)
  else
    case tokens[1]
    when 'AND' then a = evaluate(tokens[0], circuit, depth+1) & evaluate(tokens[2], circuit, depth+1)
    when 'LSHIFT' then a= evaluate(tokens[0], circuit, depth+1) << tokens[2].to_i
    when 'RSHIFT' then a=evaluate(tokens[0], circuit, depth+1) >> tokens[2].to_i
    when 'OR' then a= evaluate(tokens[0], circuit, depth+1) | evaluate(tokens[2], circuit, depth+1)
    else
      raise circuit[node].inspect
    end
  end
  puts "#{' ' * depth }caching result for #{input}: #{a}" if DEBUG
  circuit[input] = a
  a
end

circuit2 = circuit1.dup

part1 = evaluate('a', circuit1)
puts "Part 1: #{part1}"

circuit2['b'] = part1
part2 = evaluate('a', circuit2)
puts "Part 2: #{part2}"
