# frozen_string_literal: true

input = ARGF.read.split("\n\n")

stacks = input[0].split("\n")[0...-1].map do |row| # skip the last row; it's the column numbering
  row.chars.each_slice(4) # each column is 4 chars wide, of the form '[X] '
     .map { |c| c[1] } # the character we care about is the second one, array index 1
end.transpose.map(&:reverse).map { |stack| stack.reject { |c| c == ' ' } } # convert from row to column order

# Move data is of the form
#   move 3 from 1 to 3
# Split into words, take the even fields and convert to numbers
moves = input[1].split("\n").map do |row|
  row.split.each_slice(2).map(&:last).map(&:to_i)
end
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
