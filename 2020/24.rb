paths = ARGF.readlines.map &:strip

WHITE = false
BLACK = true
GRID_SIZE = 40

def split_path pathstring
  pathstring.chars.each_with_object([]).with_index do |(char, path), index|
    case char
    when 'e', 'w'
      if pathstring[index-1] == 'n' || pathstring[index-1] == 's'
        path << pathstring[index-1..index]
      else
        path << pathstring[index]
      end
    end
  end
end


grid = Array.new(GRID_SIZE) { Array.new(GRID_SIZE) { WHITE } }

paths.each do |pathstring|
  x = (GRID_SIZE/2).floor
  y = (GRID_SIZE/2).floor
 split_path(pathstring).each do |move|
   case move
   when 'e'
     x += 1
   when 'w'
     x -= 1
   when 'se'
     x += 1 if y.odd?
     y += 1
   when 'sw'
     x -= 1 if y.even? 
     y += 1
   when 'nw'
     x-= 1 if y.even? 
     y-= 1
   when 'ne' 
     x += 1 if y.odd?
     y -= 1
   end

 end
 grid[y][x] = !grid[y][x]
end

part1 = grid.flatten.count(BLACK)

puts "Part 1: #{part1}"

