INPUT = '01111001100111011'
LENGTH = 272

def step input
 input  + '0' + input.reverse.tr('10','01')
end

def checksum input
  result = input.chars.each_slice(2).map do |a,b|
    a == b ? '1' : '0'
  end
  return result.join if result.length.odd?
  checksum result.join
end

s = INPUT
while s.length < LENGTH
  s = step s
end

puts "Part 1: #{checksum s[0...LENGTH]}"
