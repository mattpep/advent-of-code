bootcode = ARGF.readlines.map do |line|
  op = line.split[0]
  data = line.split[1].to_i
  [op, data]
end

INFINITE = 1
TERMINATE = 0

def execute program
  acc = 0
  pc = 0
  seen = []
  while pc < program.size
    break if seen.include? pc
    seen << pc
    case program[pc][0]
    when 'nop' then  pc += 1
    when 'acc' then  acc += program[pc][1]; pc += 1
    when 'jmp' then  pc += program[pc][1]
    end
    break if pc >= program.size
  end
  completion = pc >= program.size ? TERMINATE : INFINITE
  [completion, acc]
end

puts "Part 1: #{ execute(bootcode).last }"

bootcode.each_with_index do |instr, addr|
  corruption = Marshal.load Marshal.dump bootcode
  case instr[0]
  when 'acc' then next
  when 'nop' then corruption[addr][0] = 'jmp'
  when 'jmp' then corruption[addr][0] = 'nop'
  end

  result = execute corruption
  if result[0] == TERMINATE
    puts "Part 2: #{ result[1] }"
    exit
  end
end
