data = ARGF.readlines.map &:strip

def split_records arr
  lines = []
  arr.each_with_object([]) do |line, result|
    if line.empty?
      record = text_to_hash lines
      lines = []
      result << record
    else
      lines << line
    end
  end
end

def text_to_hash text
  text.map(&:split).flatten.each_with_object({}) do |field, hash|
      key, value = field.split ':'
      hash[key] = value
    hash
  end
end

def valid? record
  required =%w[ byr iyr eyr hgt hcl ecl pid ]
  # optional = %i[ cid ]
  required.all? { |field| record.has_key? field }
end

records = split_records data
puts "Part 1: #{records.filter { |r| valid? r }.count}"
