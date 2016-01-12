module Lang
  class Lexer
    def initialize(str)
      @str = str
      @offset = 0
    end

    def next_token
      TOKENS.each do |token|
        match = token[1].match @str, @offset
        if match
          value = token[2].(match) if token[2]  
          tok = Token.new(type: token[0], value: value)
          @offset += match[0].size
          if [:COMMENT, :WHITESPACE].include? token[0]
            return next_token
          else
            return tok
          end
        end
      end
      return nil if @offset >= @str.size
      raise Exception, "unexpected symbol #{@str[@offset]}"
    end

    TOKENS = [
      [:WHITESPACE, /[ \t\f]+/m ],
      [:NEWLINE, /[\n\r]/m],
      [:LIT, /[01]/, ->(match){ match[0].to_i }],
      [:IDENT, /[a-zA-Z]/, ->m { m[0] }],
      [:PLUS, /\+/m, ->m { m[0] } ],
      [:NOT, /~/m, ->m { m[0] } ],
      [:LPAREN, /\(/m, ->m { m[0] } ],
      [:RPAREN, /\)/m, ->m { m[0] } ],
      [:STAR, /\*/m, ->m { m[0] } ],
    ].map do |rule|
      [rule[0], /\G#{rule[1].source}/m, rule[2]]
    end
  end
end
