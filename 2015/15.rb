ingredients = ARGF.readlines.each_with_object({}) do |line, ingreds|
  ing, properties = line.strip.split ':'
  p = properties.split(', ').each_with_object({}) do |prop,hash|
    p,q = prop.split
    hash[p] = q.to_i
  end

  ingreds[ing] = p
end


def four_parts
  (1..96).each do |a|
    (1..96).each do |b|
      next if a + b > 98
      (1..96).each do |c|
        next if a + b + c > 99
        d = 100 - a -b -c
        yield [a,b,c,d]
      end
    end
  end
end

def calculate_calories ingred, quants
  ingreds = ingred.keys.sort

  pairings = ingreds.zip quants

  cals = pairings.map do |ing, qty|
    ingred[ing]['calories'] * qty
  end.reduce(:+)
end

def score ingred, quants
  ingreds = ingred.keys.sort

  pairings = ingreds.zip quants

  attributes = ingred.each_pair.to_a[0][1].keys

  attributes.reject {|k,_| k == 'calories'}.map do |attr|
    part_score = pairings.map do |ing, qty|
      ingred[ing][attr] * qty
    end.reduce(:+)
    part_score = 0 if part_score < 0
    part_score
  end.reduce(:*)
end

part1 = part2 = -99
four_parts do |quad|
    this_score = score ingredients, quad
    cals = calculate_calories ingredients, quad

    if this_score > part1
      part1 = this_score
    end
    if cals == 500 && this_score > part2
      part2 = this_score
    end
end

puts "Part 1 (max score): #{part1}"
puts "Part 1 (max score of recipes with 500 cals): #{part2}"
