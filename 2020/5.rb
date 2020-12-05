codes = ARGF.readlines.map &:strip

def seatcode_to_id code
  row = code[0...7].tr('FB', '01').to_i(2)
  col = code[7..-1].tr('LR', '01').to_i(2)

  col + row * 8
end

ids = codes.map { |code| seatcode_to_id code }

puts "Part 1: #{ids.max}"

my_id = ids.sort.each_cons(2).reject { |a,b| b == a+1 }.first.first + 1

puts "Part 2: #{my_id}"
