module AOC
  class InvalidInstructionError < StandardError; end
  class InputExhaustedError < StandardError; end

  # Used in 2019:2, 2019:5, 2019:7
  class IntcodeCPU
    POSITION  = 0
    IMMEDIATE = 1

    I_ADD = 1
    I_MUL = 2
    I_READ = 3
    I_WRITE = 4
    I_JNZ = 5
    I_JZ = 6
    I_SLT = 7
    I_SEQ = 8
    I_TERM = 99

    attr_accessor :ip, :memory, :input, :output

    def initialize
      @ip = 0
      @memory = []
      @input = nil
    end

    def load program
      self.memory = Marshal.load Marshal.dump program
    end

    def reset
      self.ip = 0
      self.output = nil
      self.input = nil
      self.memory.replace []
    end

    def execute seed=nil
      self.memory[1..2] = seed if seed
      while true
        instruction, *args = memory[ip...(ip+4)]
        op, modes = decode_op instruction
        case op
        when I_ADD
          self.memory[args[2]] = decode_value(args[0], modes[0]) + decode_value(args[1], modes[1])
          self.ip += 4
        when I_MUL
          self.memory[args[2]] = decode_value(args[0], modes[0]) * decode_value(args[1], modes[1])
          self.ip += 4
        when I_READ
          value = if input.class == Array
                    input.shift
                  else
                    input
                  end
          raise InputExhaustedError if value.nil?
          self.memory[args[0]] = value
          self.ip += 2
        when I_WRITE
          self.output = decode_value(args[0], modes[0])
          self.ip += 2
        when I_JNZ
          condition = decode_value(args[0], modes[0])
          if condition.zero?
            self.ip += 3
          else
            self.ip = decode_value(args[1], modes[1])
          end
        when I_JZ
          condition = decode_value(args[0], modes[0])
          if condition.zero?
            self.ip = decode_value(args[1], modes[1])
          else
            self.ip += 3
          end
        when I_SLT
          condition = decode_value(args[0], modes[0]) < decode_value(args[1], modes[1])
          self.memory[args[2] ] = condition ? 1 : 0
          self.ip += 4
        when I_SEQ
          condition = decode_value(args[0], modes[0]) == decode_value(args[1], modes[1])
          self.memory[args[2] ] = condition ? 1 : 0
          self.ip += 4
        when I_TERM then return memory.first
        else raise InvalidInstructionError, { op: op, addr_modes: modes, args: args}.to_s
        end
      end
      # terminated by running off end
      memory.first
    end

    private

    def decode_value value, mode
      case mode
      when IMMEDIATE
        value
      when POSITION, nil
        memory[value]
      end
    end

    def decode_op opcode
      modes, op = opcode.divmod 100
      modes = modes.digits.map(&:to_i)
      [op, modes]
    end
  end
end
