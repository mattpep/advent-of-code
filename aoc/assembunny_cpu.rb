module AOC
  class AssembunnyCPU
    # AssembunnyCPU from 2016:12
    attr_reader :debug
    attr_accessor :a, :b, :c, :d, :pc

    def initialize
      @a = 0
      @b = 0
      @c = 0
      @d = 0
      @pc = 0
      @debug = false
    end

    def debug= val
      @debug = !!val
    end

    def execute program
      while true
        instruction = program[pc]
        puts "pc: #{pc}, instruction: #{instruction}, regs: #{[a,b,c,d]}" if debug
        break if instruction.nil?
        op, *args = instruction.split(' ')
        case op
        when 'inc'
          register = args[0]
          send(register + '=', send(register) + 1)
          self.pc += 1
        when 'dec'
          register = args[0]
          send(register + '=', send(register) - 1)
          self.pc += 1
        when 'cpy'
          src = args[0]
          dst = args[1]
          if (?a..?d).include? src
            send(dst + '=', send(src))
          else
            send(dst + '=', src.to_i)
          end
          self.pc += 1
        when 'jnz'
          test = args[0]
          offset = args[1]
          self.pc += if ((?a..?d).include?(test) ? send(test) : test.to_i) != 0
                       offset.to_i
                     else
                       1
                     end
        else
          puts "Invalid instruction #{instruction}"
          break
        end
      end
    end
  end
end
