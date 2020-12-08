bootcode = ARGF.readlines.map do |line|
  op = line.split[0]
  data = line.split[1].to_i
  [op, data]
end

acc = 0
pc = 0
seen = []

while true
  break if seen.include? pc
  seen << pc
  case bootcode[pc][0]
  when 'nop' then  pc += 1
  when 'acc' then  acc += bootcode[pc][1]; pc += 1
  when 'jmp' then  pc += bootcode[pc][1]
  else
    puts "Invalid opcode #{bootcode[pc][0]} in instruction: #{bootcode[pc]} at address #{pc}"
  end
end

puts "Part 1: #{ acc }"

