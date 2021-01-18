require 'digest'

SALT = 'qzyelonm'

class String
  def has_5_adjacent_repeats_of? char
    chars.each_cons(5).any? { |cons| cons.count(char) >= 5 }
  end

  def find_3_repeated_char
    repeated = nil
    chars.each_cons(3).any? { |a,b,c| a == b && b == c && repeated = a }
    repeated
  end
end

number = -1
64.times do |x|
  while true
    number += 1
    repeated = Digest::MD5.hexdigest(SALT + number.to_s).find_3_repeated_char
    if repeated
      if (number+1..(number+1000)).any? { |n| Digest::MD5.hexdigest(SALT + n.to_s).has_5_adjacent_repeats_of? repeated }
        break
      end
    end
  end
end
puts "part 1: 64th key was generated with index #{number}"
