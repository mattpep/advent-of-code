input = ARGF.readlines.map &:strip

class CPU
  attr_accessor :watches
  attr_reader :signal

  def initialize
    self.watches = Array.new
    @program = Array.new
    @pc = 0
    @x = 0
  end

  def is_watched?(addr)
    self.watches.include? addr
  end

  def load_program(lines)
    @program = lines.map do |line|
      fields = line.split
      instr = { opcode: fields[0] }

      if instr[:opcode] == 'addx'
        instr[:parameter] = fields[1].to_i
      end

      instr
    end
  end

  def run
    signal = 0
    @x = 1
    waited = false
    cycle = 1

    while true
      if @program[@pc][:opcode] == "addx"
        if waited == false
          # puts "   first cycle, so skipping"
        else
          # puts "   second cycle, so executing"
        end
      else
        # puts " noop"
      end

      this_signal = @x * cycle
      if is_watched? cycle
        signal += this_signal
      end
      
      if @program[@pc][:opcode] == 'addx'
        if !waited
          waited = true
        else
          waited = false
            @x +=  @program[@pc][:parameter]
            @pc += 1
        end
      elsif @program[@pc][:opcode] == 'noop'
            @pc += 1
      else
        puts "Unknown instruction #{@program[@pc][:opcode]} at addr #{@program[@pc]}"
      end

      cycle += 1

      # puts "end of cycle #{cycle.pred}, x = #{@x}"
      break if @pc >= @program.size
    end
    signal
  end

end


cpu = CPU.new
cpu.load_program(input)
cpu.watches = [20, 60, 100, 140, 180, 220]
signal = cpu.run

puts "Part 1 (signal strength): #{signal}"
