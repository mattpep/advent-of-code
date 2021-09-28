original = ARGF.readline.strip

def find_poly_length polymer
  changed = true
  while changed
    changed = false
    (0...polymer.length-1).each do |x|
      if polymer[x].downcase == polymer[x+1].downcase && (polymer[x].ord - polymer[x+1].ord).abs == 32
        polymer.replace( polymer[0...x] + polymer[x+2..-1].to_s)
        changed = true
        break
      end
    end
  end
  polymer.length
end

polymer = original.dup
puts "part 1: Final length of polymer: #{find_poly_length polymer}"

part2 = original.downcase.chars.uniq.sort.map do |remove|
  polymer = original.dup
  polymer.tr!("#{remove}#{remove.upcase}", '')
  find_poly_length(polymer)
end.min
puts "part 2: #{part2}"
