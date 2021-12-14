pattern = ARGF.readline.strip
_ = ARGF.readline
rules = ARGF.readlines.each_with_object(Hash.new) do |line, hash|
  k, v = line.strip.split ' -> '
  hash[k] = v
end


10.times do |i|
  new_pattern = ''
  pattern.chars.each_cons(2) do |a,b|
    new_pattern += a
    if rules[a+b]
      new_pattern += rules[a+b]
    end
  end
  new_pattern += pattern.chars.last
  pattern.replace new_pattern
end

class String
  def char_counts
    self.chars.each_with_object(Hash.new) do |char, hash|
      hash[char] = hash[char].to_i + 1
    end
  end
end

part1 = pattern.char_counts.max_by { |_, count| count }[1] - pattern.char_counts.min_by { |_, count| count }[1]
puts "Part 1: #{part1}"
