PATTERN = /(?<encname>([a-z]+-)*[a-z]+)-(?<sector>\d+)\[(?<checksum>[a-z]+)\]/
rooms = ARGF.readlines.map &:strip

def frequencies s
  letters = s.split('-').join.chars
  freqs = letters.uniq.each_with_object({}) { |letter, hash| hash[letter] = letters.count(letter) }
  freqs.each_pair.sort_by { |item| [-item.last, item.first.ord] }
end

def calculate_checksum enc_name
  enc_name.match(PATTERN) do |m|
    f = frequencies m[:encname]
    checksum = f[0...5].map(&:first).join
    return checksum
  end
end

def valid_checksum? enc_name
  expected_checksum = calculate_checksum enc_name
  enc_name.match(PATTERN) do |m|
    return true if expected_checksum == m[:checksum]
  end
end

def roll_letter l, qty
  offset = l.ord - ?a.ord
  offset += qty
  offset %= 26
  (?a.ord + offset).chr
end

def decode_name enc_name
  name = ''
  enc_name.match(PATTERN) do |m|
    id = m[:sector].to_i
    name = m[:encname]
    name = name.chars.map do |char|
      if char == '-'
        ' '
      elsif (?a..?z).include? char
        roll_letter char, id
      else
        char
      end
    end.join
  end
  name
end

expected = ''
sector_id = 0
calculated_checksum = ''
part2_id = 0
reals = rooms.select { |room| valid_checksum?(room) }


part1 = reals.sum do |room|
  room.match(PATTERN) do |m|
    m[:sector].to_i
  end
end

puts "Part 1: #{part1}"
part2 = reals.select do |enc_name|
  decode_name(enc_name).start_with? 'northpole object storage'
end.first
puts "Part 2: #{part2}"
