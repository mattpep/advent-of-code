polymer = ARGF.readline.strip

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
puts "Final length of polymer: #{polymer.size}"

