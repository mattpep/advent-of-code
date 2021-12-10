module AOC
  class SyntaxEngine
    ROUND  = '('
    CURLY  = '{'
    ANGLE  = '<'
    SQUARE = '['

    attr_reader :corrupt, :score

    def initialize data
      @data = data
      @corrupt = false
      @score = 0
      @stack = []
      parse
    end

    def autocomplete_score
      needed = @stack.join.reverse.tr '({<[', ')}>]'
      score = 0
      needed.chars.each do |char|
        score *= 5
        score += case char
                 when ')' then 1
                 when ']' then 2
                 when '}' then 3
                 when '>' then 4
                 end
      end
      score
    end

    def parse
      @data.chars.each do |char|
        case char
        when ANGLE, ROUND, SQUARE, CURLY # opening
          @stack << char
        when '>'
          if @stack.pop != ANGLE
            @corrupt = true
            @score += 25137 if @score == 0
          end
        when ')'
          if @stack.pop != ROUND
            @corrupt = true
            @score += 3 if @score == 0
          end
        when ']'
          if @stack.pop != SQUARE
            @corrupt = true
            @score += 57 if @score == 0
          end
        when '}'
          if @stack.pop != CURLY
            @corrupt = true
            @score += 1197 if @score == 0
          end
        end
      end
    end

    def incomplete?
      !corrupt && @stack.length > 0
    end

  end
end
