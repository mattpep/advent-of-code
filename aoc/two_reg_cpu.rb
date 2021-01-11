module AOC
  class TwoRegCPU
    # 2-register CPU from 2015:23

    attr_accessor :a, :b, :pc

    def initialize a: 0, b: 0
      @a = a
      @b = b
      @pc = 0
    end

    def execute program
      while true
        instruction = program[pc]
        break if instruction.nil?
        op, args = instruction.split(' ', 2)
        case op
        when 'hlf' # half
          self.a /=2 if args == 'a'
          self.b /=2 if args == 'b'
          self.pc += 1
        when 'tpl' # triple
          self.a *=3 if args == 'a'
          self.b *=3 if args == 'b'
          self.pc += 1
        when 'inc' # increment
          self.a+=1 if args == 'a'
          self.b+=1 if args == 'b'
          self.pc += 1
        when 'jmp' # jump
          self.pc += args.to_i
        when 'jie' # jump if even
          if args.split(',')[0] == 'a' && a.even?
            self.pc += args.split(',')[1].to_i
          elsif args.split(',')[0] == 'b' && b.even?
            self.pc += args.split(',')[1].to_i
          else
            self.pc += 1
          end
        when 'jio' # jump if ONE
          self.pc += if args.split(',')[0] == 'a' && a == 1
                       args.split(',')[1].to_i
                     elsif args.split(',')[0] == 'b' && b == 1
                       args.split(',')[1].to_i
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
