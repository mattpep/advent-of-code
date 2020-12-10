memory = ARGF.read.split(',').map &:to_i

PART2_TARGET = 19690720

def execute program, seed
  memory = Marshal.load Marshal.dump program
  pc = 0
  memory[1..2] = seed
  while true
    instruction = memory[pc...(pc+4)]
    case instruction[0]
    when 1
      memory[instruction[3]] = memory[instruction[1]] + memory[instruction[2]]
    when 2
      memory[instruction[3]] = memory[instruction[1]] * memory[instruction[2]]
    when 99 then return memory.first
    end
    pc += 4
  end
end

puts "Part 1: #{execute memory, [12,02] }"

(0..99).each do |x|
  (0..99).each do |y|
    cell0 = execute memory, [x,y]
    if cell0 == PART2_TARGET
      puts "Part 2: #{100*x + y}"
      exit
    end
  end
end
