passwords = ARGF.readlines.map &:strip

length = passwords.first.length

password = [nil] * length

length.times do |idx|
  frequencies = passwords.map { |p| p[idx] }.each_with_object({}) do |char, hash|
    hash[char] = 0 if hash[char].nil?
    hash[char] += 1
  end
  password[idx] = frequencies.max_by { |_,count| count }[0]
end
puts "Part 1: #{password.join}"



password = [nil] * length

length.times do |idx|
  frequencies = passwords.map { |p| p[idx] }.each_with_object({}) do |char, hash|
    hash[char] = 0 if hash[char].nil?
    hash[char] += 1
  end
  password[idx] = frequencies.min_by { |_,count| count }[0]
end



puts "Part 2: #{password.join}"
