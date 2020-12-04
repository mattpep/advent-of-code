data = ARGF.readlines.map &:strip

KEYPAD = [ [1,2,3], [4,5,6], [7,8,9] ]

def move direction, start
  x = start.first
  y = start.last
  case direction
  when 'U' then x -= 1 if x != 0
  when 'D' then x += 1 if x < 2
  when 'L' then y -= 1 if y != 0
  when 'R' then y += 1 if y < 2
  end
  [x, y]
end
code = []

data.each do |key|
  location = [1,1]
  key.chars.each { |dir| location = move(dir, location) }
  code << KEYPAD[location.first][location.last]
end

puts "Part 1: #{code.join}"


COMPLEX = [ [nil, nil, 1, nil, nil], [nil, 2, 3, 4, nil], [5, 6, 7, 8, 9], [nil, ?A, ?B, ?C, nil], [nil, nil, ?D, nil, nil] ]

def move direction, start
  x = start.first
  y = start.last
  case direction
  when 'U' then x -= 1 if x != 0 && COMPLEX[x-1][y]
  when 'D' then x += 1 if x < 4 && COMPLEX[x+1][y]
  when 'L' then y -= 1 if y != 0 && COMPLEX[x][y-1]
  when 'R' then y += 1 if y < 4 && COMPLEX[x][y+1]
  end
  [x, y]
end
code = []

data.each do |key|
  location = [1,1]
  key.chars.each { |dir| location = move(dir, location) }
  code << COMPLEX[location.first][location.last]
end

puts "Part 2: #{code.join}"
