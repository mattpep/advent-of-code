start = 'abcdefgh'

sequence = start.chars
steps = ARGF.readlines.map &:strip

steps.each do |step|
  operation = step.split[0...2].join ' '
  args = step.split[2..-1]
  case operation
  when 'rotate right' then sequence.rotate! -args[0].to_i
  when 'rotate left' then sequence.rotate! args[0].to_i
  when 'rotate based' # on position of letter <a>
    count = sequence.index(args[4])
    count += 1 if count >= 4
    count += 1
    sequence.rotate! -count
  when 'swap position' # <x> with position <y>
    indexes = [args[0].to_i, args[3].to_i]
    sequence[indexes[0]], sequence[indexes[1]] = sequence[indexes[1]], sequence[indexes[0]]
  when 'swap letter' # <a> with letter <b>
    letters = [ args[0], args[3] ]
    indexes = letters.map { |l| sequence.index l }
    sequence[indexes[0]], sequence[indexes[1]] = sequence[indexes[1]], sequence[indexes[0]]
  when 'move position' # <x> to position <y>
    char = sequence.delete_at args[0].to_i
    sequence.insert(args[3].to_i , char)
  when 'reverse positions' # <x> through <y>
    indexes = [args[0], args[2]].map &:to_i
    left = sequence[0...(indexes[0])]
    middle = sequence[indexes[0]..indexes[1]]
    right = sequence[(indexes[1]+1)..-1]

    sequence.replace [left, middle.reverse, right].join.chars
  else
    raise StandardError, "Unknown move: #{operation}"
  end
  # puts "result at end of step: #{sequence.inspect}, length is #{sequence.length}"
end

puts "Part 1: #{sequence.join}"
