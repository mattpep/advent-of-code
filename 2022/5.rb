input = ARGF.read.split("\n\n")

stacks = input[0].split("\n")[0...-1].map {|row| row.chars.each_slice(4).map{|c| c[1]}}.transpose.map(&:reverse).map{|stack| stack.reject{|c| c == ' '}}
moves = input[1].split("\n").map {|row| row.split}.map {|fields| [fields[1], fields[3], fields[5]].map(&:to_i)}

stacks1 = Marshal.load Marshal.dump(stacks)
stacks2 = Marshal.load Marshal.dump(stacks)

moves.each do |move|
  move[0].times do
    stacks1[move[2].pred] << stacks1[move[1].pred].pop
  end
end
puts stacks1.map(&:last).join

moves.each do |move|
  stacks2[move[2].pred] += stacks2[move[1].pred].pop(move[0])
end
puts stacks2.map(&:last).join
