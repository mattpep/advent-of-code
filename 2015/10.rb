START = 1321131112
COUNTS = [40, 50]

def looksay n
  n = n.to_s if n.kind_of? Integer

  n.chars.each_with_object([]) do |digit, result|
    if result.last && (digit == result.last[1])
      result.last[0] += 1
    else
      result << [1, digit]
    end
  end.flatten.map(&:to_s).join
end

COUNTS.each_with_index do |count, part|
  s = START
  count.times { |_| s = looksay s }
  puts "Part #{part+1}: #{s.length}"
end
