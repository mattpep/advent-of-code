field = ARGF.readlines


pos_x = 0
pos_y = 0
tree_count = 0
target_y = field.count

while pos_y < target_y do
  puts "\e[H\e[2J"
  field[0..80].each_with_index do |row_content, row_idx|
    if pos_y == row_idx
      tmprow = row_content.dup
      tmprow[pos_x] = '@'
      puts tmprow
    else
      puts row_content
    end
  end
  puts "Target row: #{target_y}, current row: #{pos_y} (column #{pos_x}), cell #{field[pos_y][pos_x]}"
  if field[pos_y][pos_x] == '#'
    tree_count+=1
  end
  pos_y+=1
  pos_x+=3
  if pos_x+1 >= field.first.length
    pos_x -= field.first.length
    pos_x += 1
  end
  # sleep 1
end
puts "Part 1: #{tree_count}"

