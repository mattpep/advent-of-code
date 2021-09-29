TARGET_CELL = [2978, 3083]
STARTVAL = 20151125
INCREMENT_MULTIPLE = 252533
INCREMENT_MODULUS = 33554393

def next_value_for(x)
  (x * INCREMENT_MULTIPLE) % INCREMENT_MODULUS
end

row_progress = cur_row = cur_col = 1
current_value = STARTVAL


while [cur_row, cur_col] != TARGET_CELL
  if cur_row == 1
    cur_col = 1
    row_progress += 1
    cur_row = row_progress
  else
    cur_col += 1
    cur_row -= 1
  end
  current_value = next_value_for(current_value)
end

puts "Part 1: #{current_value}"
