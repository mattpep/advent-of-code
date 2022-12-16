data = ARGF.read.split("\n\n").map { |m| m.split "\n" }

class Circle
  attr_reader :monkeys

  def initialize
    @monkeys = []
  end

  def add(monkey)
    @monkeys << monkey
  end

  def monkey_business
    monkeys.map(&:inspections).max(2).reduce(:*)
  end

  def modulus
    monkeys.map(&:modulus).reduce(:*)
  end

end

class Monkey
  attr_accessor :inspections
  attr_reader :id, :modulus

  def initialize(circle, record, worrying=false)
    @circle = circle
    @worrying = worrying
    @id = record[0].split.last[0..-2].to_i
    self.inspections = 0
    @items = record[1].split[2..-1].map { |item| item.chomp(',').to_i }
    @operation = Proc.new do |x|
      fields =  record[2].split[4..5]
      if fields[1] == 'old'
        x.to_i.send(fields[0].to_sym, x.to_i)
      else
        fields[1].to_i.send(fields[0].to_sym, x.to_i)
      end
    end
    @modulus = record[3].split.last.to_i
    @test = lambda { |x| x % record[3].split.last.to_i == 0 }
    @targets = {
      true =>  record[4].split.last.to_i,
      false =>  record[5].split.last.to_i
    }
  end

  def throw
    @items.shift
  end

  def catch item
    @items.push item
  end

  def tick
    @items.dup.each do |item|
      old = item
      item = @operation.call(item)
      item /= 3 unless @worrying
      item = item.floor
      item %= @circle.modulus

      test_result = @test.call(item)
      target = @targets[ test_result ]
      self.throw
      @circle.monkeys[target].catch item
      self.inspections+=1
    end
  end

  def show
    puts "Monkey #{@id}, holding:#{@items}, inspections: #{inspections}"
  end
end

circle1 = Circle.new
circle2 = Circle.new
data.each do |record|
  monkey= Monkey.new circle1, record
  circle1.add monkey

  monkey= Monkey.new circle2, record, "worrying"
  circle2.add monkey
end

20.times do |x|
  circle1.monkeys.each { |m| m.tick }
  # puts "\nAfter #{x.succ} times"
  # circle.monkeys.each { |m| m.show }
end

puts "Part 1 (monkey business): #{circle1.monkey_business}"

10000.times do |x|
  circle2.monkeys.each { |m| m.tick }
  # if x % 500 == 0
  #   puts "\nAfter #{x.succ} times"
  #   circle2.monkeys.each { |m| m.show }
  # end
end

puts "Part 2 (monkey business): #{circle2.monkey_business}"
