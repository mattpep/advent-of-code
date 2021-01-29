PATTERN = /position=<(?<x_pos>( |-)\d+), (?<y_pos>( |_)\d+)> velocity=<(?<x_vel>( |-)\d+), (?<y_vel>( |-)\d+)>/
STAR = '*'
SPACE = ' '
records = ARGF.readlines.map &:strip

stars = records.each_with_object(Array.new) do |record, arr|
  record.match(PATTERN) do |m|
    arr << {
      x_pos: m[:x_pos].to_i,
      y_pos: m[:y_pos].to_i,
      x_vel: m[:x_vel].to_i,
      y_vel: m[:y_vel].to_i,
    }
  end
end

last_height = nil
steps = 0
while true
  stars.map! do |star|
    star[:x_pos] += star[:x_vel]
    star[:y_pos] += star[:y_vel]
    star
  end

  width = stars.map { |s| s[:x_pos] }.minmax.reverse.reduce :-
  height = stars.map { |s| s[:y_pos] }.minmax.reverse.reduce :-
  break if last_height && last_height< height
  last_starfield = Marshal.load Marshal.dump stars
  last_height = height
  steps += 1
end

puts "ready after #{steps} steps"
x_bounds = stars.map { |s| s[:x_pos] }.minmax
y_bounds = stars.map { |s| s[:x_pos] }.minmax

puts "Part 1:"
(x_bounds[0]..x_bounds[1]).each do |x|
  (y_bounds[0]..y_bounds[1]).map do |y|
    last_starfield.any? { |star| star[:x_pos] == x && star[:y_pos] == y } ? STAR : SPACE
  end.join.tap { |row| puts row.reverse }
end

puts "Part 2: #{steps}"
