lines = ARGF.readlines.map &:strip

def unescape s
  s.gsub(/(\\x..)|(\\")|(\\\\)/) do |sub|
    case sub[1]
    when '"' then '"'
    when '\\' then '\\'
    when 'x' then sub[2..-1].to_i(16).chr
    else sub
    end
  end[1..-2]
end

def escape s
  middle = s.gsub(/["\\]/) do |sub|
    case sub
    when '"' then '\"'
    when '\\' then '\\\\'
    # when 'x' then sub[2..-1].to_i(16).chr
    else sub
    end
end
  %Q("#{middle}")
end

original = lines.map(&:chars).map(&:length).sum
unescaped = lines.map { |line| unescape(line.dup).length }.sum

puts "Part 1: #{original - unescaped}"

escaped = lines.map { |line| escape(line.dup).length }.sum
puts "Part 1: #{escaped - original}"
