require 'digest'

LENGTH = 8
SECRET = 'reyedfim'


number = 0
part1 = ''

LENGTH.times do |_|
  while true
    digest = Digest::MD5.hexdigest(SECRET + number.to_s)
    number+=1
    if digest.start_with? '0' * 5
      part1 += digest[5]
      break
    end
  end
end

puts "Part 1: #{part1}"

part2 = [nil] * LENGTH
number = 0
while part2.reject(&:nil?).count < LENGTH
  digest = Digest::MD5.hexdigest(SECRET + number.to_s)
  number+=1
  if digest.start_with? '0' * 5
    pos, char = digest[5..6].chars
    next unless (?0...?8).include? pos
    position = pos.to_i
    next unless part2[position].nil?
    part2[position] = char
  end
end
puts "Part 2: #{part2.join}"
