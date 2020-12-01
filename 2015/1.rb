data = ARGF.read

part1 = data.chars.map do |ch|
  case ch
  when ')' then -1
  when '(' then 1
  else 0
  end
end.sum
puts "Part 1 solution: #{part1}"

floor = 0

data.chars.each_with_index.map do |ch, index|
  floor += case ch
  when ')' then -1
  when '(' then 1
  else 0
  end
  if floor.negative?
    puts "Part 2 solution: Basement entered on character #{index+1}"
    exit
  end
end
puts "Part 2 solution not found"
