RECORD_FORMAT = /^(?<num1>\d+)-(?<num2>\d+) (?<letter>[a-z]): (?<password>[a-z]+)$/

def check_1 entry
  a = entry.match(RECORD_FORMAT) do |m|
    lower = m[:num1].to_i
    upper = m[:num2].to_i
    letter= m[:letter]
    password= m[:password]

    return true if (lower..upper).include? password.count(letter)
  end
end

def check_2 entry
  a = entry.match(RECORD_FORMAT) do |m|
    pos_1 = m[:num1].to_i
    pos_2 = m[:num2].to_i
    letter= m[:letter]
    password= m[:password]

    return true if (letter == password[pos_1-1]) != (letter == password[pos_2-1])
  end
end

passwords = ARGF.readlines
puts "Part 1: #{ passwords.filter { |p| check_1 p }.count }"
puts "Part 2: #{ passwords.filter { |p| check_2 p }.count }"
