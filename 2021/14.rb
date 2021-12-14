pattern = ARGF.readline.strip
_ = ARGF.readline
rules = ARGF.readlines.each_with_object(Hash.new) do |line, hash|
  k, v = line.strip.split ' -> '
  hash[k] = v
end

class String
  def char_counts
    self.chars.each_with_object(Hash.new) do |char, hash|
      hash[char] = hash[char].to_i + 1
    end
  end

  def digraph_replace digraphs
    new_pattern = ''
    self.chars.each_cons(2) do |a,b|
      new_pattern += a
      new_pattern += digraphs[a+b] if digraphs[a+b]
    end
    new_pattern += self[-1]
    self.replace new_pattern
  end
end

10.times { pattern.digraph_replace rules }

part1 = pattern.char_counts.max_by { |_, count| count }[1] - pattern.char_counts.min_by { |_, count| count }[1]
puts "Part 1: #{part1}"
