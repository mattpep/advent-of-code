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

end

class Monkey
  attr_accessor :inspections
  attr_reader :id

  def initialize(circle, record)
    @circle = circle
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
      item /= 3
      item = item.floor

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

circle = Circle.new
data.each do |record|
  monkey= Monkey.new circle, record
  circle.add monkey
end

20.times do |x|
  circle.monkeys.each { |m| m.tick }
  # puts "\nAfter #{x.succ} times"
  # circle.monkeys.each { |m| m.show }
end

puts "Part 1 (monkey business): #{circle.monkey_business}"
