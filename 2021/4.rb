NUMBERS = ARGF.readline.split(',').map &:to_i

_ = ARGF.readline

GRIDS = ARGF.read.split("\n\n").map do |row|
  row.split("\n").map do |column|
    column.split.map &:to_i
  end
end


class Grid
  attr_accessor :cells, :last_call

  def initialize numbers
    self.cells = numbers.each_with_object([]) do |row, arr|
      arr << []
      row.each do |num|
        arr.last << { number: num, marked: false }
      end
    end
    self.last_call = nil
  end

  def win?
    cells.each do |row|
      return true if row.all? { |cell| cell[:marked] }
    end
    cells.transpose.each do |col|
      return true if col.all? { |cell| cell[:marked] }
    end
    false
  end

  def score
    return 0 unless win?
    last_call * cells.flatten.reject { |cell| cell[:marked] }
                     .map { |cell| cell[:number] }
                     .sum
  end

  def process number
    return if win? # don't process any more numbers when won; we don't want to alter our score
    cells.each do |row|
      row.each do |cell|
        if number == cell[:number]
          cell[:marked] = true
        end
      end
    end
    self.last_call = number
  end
end

players = Array.new(GRIDS.count) do |i|
  Grid.new(GRIDS[i])
end

part1 = nil
NUMBERS.each do |num|
  players.each do |player|
    player.process num
    if player.win? && !part1
      if players.select(&:win?).count == 1
        part1 = player.score
        puts "Part 1: #{part1}"
      end
    end
    if players.reject(&:win?).count == 0
      part2 = player.score
      puts "Part 2: #{part2}"
      exit
    end
  end
end

