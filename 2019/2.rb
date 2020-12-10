memory = ARGF.read.split(',').map &:to_i

pc = 0

memory[1] = 12
memory[2] = 2

while true
  instruction = memory[pc...(pc+4)]
  case instruction[0]
  when 1
    memory[instruction[3]] = memory[instruction[1]] + memory[instruction[2]]
  when 2
    memory[instruction[3]] = memory[instruction[1]] * memory[instruction[2]]
  when 99 then
    puts memory.first
    exit
  end
  pc += 4
end
