program = ARGF.readlines.map &:strip


a = 0
b = 0
pc = 0

while true
  instruction = program[pc]
  break if instruction.nil?
  op, args = instruction.split(' ', 2)
  case op
  when 'hlf' # half
    a /=2 if args == 'a'
    b /=2 if args == 'b'
    pc += 1
  when 'tpl' # triple
    a *=3 if args == 'a'
    b *=3 if args == 'b'
    pc += 1
  when 'inc' # increment
    a+=1 if args == 'a'
    b+=1 if args == 'b'
    pc += 1
  when 'jmp' # jump
    pc += args.to_i
  when 'jie' # jump if even
    if args.split(',')[0] == 'a' && a.even?
      pc += args.split(',')[1].to_i
    elsif args.split(',')[0] == 'b' && b.even?
      pc += args.split(',')[1].to_i
    else
      pc += 1
    end
  when 'jio' # jump if ONE
    if args.split(',')[0] == 'a' && a == 1
      pc += args.split(',')[1].to_i
    elsif args.split(',')[0] == 'b' && b == 1
      pc += args.split(',')[1].to_i
    else
      pc += 1
    end
  else
    puts "Invalid instruction #{instruction}"
    break
  end
end

puts "Part 1: #{b}"
