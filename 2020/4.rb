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

def valid? record, strict=false
  required =%w[ byr iyr eyr hgt hcl ecl pid ]
  # optional = %i[ cid ]
  return false unless required.all? { |field| record.has_key? field }
  return true unless strict
  return false unless (1920..2002).include? record['byr'].to_i
  return false unless (2010..2020).include? record['iyr'].to_i
  return false unless (2020..2030).include? record['eyr'].to_i

  unit = record['hgt'][-2,2]
  value = record['hgt'][0...-2]
  case unit
  when 'cm'
    return false unless (150..193).include? value.to_i
  when 'in'
    return false unless (59..76).include? value.to_i
  else
    return false #unknown unit
  end

  return false unless record['hcl'] =~ /^#[0-9a-f]{6}$/
  return false unless %w[amb blu brn gry grn hzl oth].include? record['ecl']
  return false unless record['pid'] =~ /^\d{9}$/
  true
end

records = split_records data
puts "Part 1: #{records.filter { |r| valid? r }.count}"
puts "Part 2: #{records.filter { |r| valid?(r, 'strict') }.count}"
