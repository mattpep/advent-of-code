module AOC
  
  # Used in 2019:2
  class IntcodeCPU
    attr_accessor :ip, :memory

    def initialize
      @ip = 0
      @memory = []
    end

    def load program
      self.memory = Marshal.load Marshal.dump program
    end

    def reset; self.ip = 0 ; end

    def execute seed=nil
      self.memory[1..2] = seed if seed
      while true
        instruction = memory[ip...(ip+4)]
        case instruction[0]
        when 1
          memory[instruction[3]] = memory[instruction[1]] + memory[instruction[2]]
        when 2
          memory[instruction[3]] = memory[instruction[1]] * memory[instruction[2]]
        when 99 then return memory.first
        end
        self.ip += 4
      end
      # terminated by running off end
      memory.first
    end
  end
end
