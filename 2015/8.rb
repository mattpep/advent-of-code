lines = ARGF.readlines.map &:strip

def unescape s
  s.gsub(/(\\x..)|(\\")|(\\\\)/) { |sub|
    case sub[1]
    when '"' then '"'
    when '\\' then '\\'
    when 'x' then sub[2..-1].to_i(16).chr
    else sub
    end
  }[1..-2]
end

code = lines.map(&:chars).map(&:length).sum
data = lines.map { |line| unescape(line.dup).length }.sum

puts "Part 1: #{code-data}"
