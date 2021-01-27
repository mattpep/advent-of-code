program = ARGF.readlines.map &:strip

PATTERN = /(?<register>\w+) (?<op>(inc|dec)) (?<amount>-?\d+) if (?<test>\w+) (?<comparison>[^ ]+) (?<target>-?\d+)/

registers = Hash.new
ever_max = 0
program.each do |instruction|
  # puts "Instruction: #{instruction}"
  instruction.match(PATTERN) do |m|
    registers[m[:register]] ||= 0
    registers[m[:test]] ||= 0

    target = m[:target].to_i
    amount = m[:amount].to_i
    if registers[ m[:test] ].send(m[:comparison].to_sym, target)
      case m[:op]
      when 'inc' then registers[m[:register]] += amount
      when 'dec' then registers[m[:register]] -= amount
      end
    end
  end
  ever_max = [ever_max, registers.values.max].max
end

puts "Part 1: #{registers.values.max}"
puts "Part 2: #{ever_max}"
