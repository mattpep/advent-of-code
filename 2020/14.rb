initialization = ARGF.readlines.map(&:strip)

MEMORY_PATTERN = /mem\[(?<address>\d+)\] = (?<value>\d+)/
WORD_SIZE = 36

def calculate_result value, mask
  cell_bits = value.to_s(2).rjust(WORD_SIZE, '0')
  result = (0..WORD_SIZE).map do |bit|
    mask[bit] == 'X' ?  cell_bits[bit] : mask[bit]
  end
  result.join.to_i(2)
end

memory = Hash.new
initialization.slice_before do |line|
  line.start_with? 'mask ='
end.each do |chunk|
  mask = chunk.first[7..-1]
  chunk[1..-1].each do |mem_line|
    mem_line.match(MEMORY_PATTERN) do |m|
      memory[ m[:address].to_i ] = calculate_result(m[:value].to_i, mask)
    end
  end
end

puts "Part 1: #{memory.values.sum}"
