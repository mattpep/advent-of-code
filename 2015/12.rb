data = ARGF.read

require 'json'

json = JSON.parse data

def evaluate n, remove_red=false
  case n.class.to_s
  when 'Integer' then n
  when 'Array' then n.map{|x| evaluate x, remove_red}.sum
  when 'Hash'
    if (remove_red && n.values.any? {|v| v == 'red' })
      0
    else
      n.values.map {|x| evaluate x, remove_red}.sum
    end
  when 'String' then 0
  end
end

puts "Part 1: #{evaluate json}"
puts "Part 2: #{evaluate json, 'remove red'}"
