data = ARGF.readlines.map(&:strip).map &:chars

gamma = Array.new
epsilon = Array.new

counts = data.first.length.times do |bit|
  zeros = data.map { |record| record[bit] }.count('0')
  ones = data.map { |record| record[bit] }.count('1')

  if zeros > ones
    gamma.append 0
    epsilon.append 1
  else
    gamma.append 1
    epsilon.append 0
  end
end

power = gamma.join('').to_i(2) * epsilon.join('').to_i(2)
puts "Part 1: #{power}"
