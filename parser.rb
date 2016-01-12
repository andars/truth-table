require 'set'
module Lang
  class Parser
    def initialize(str)
      @lexer = Lexer.new(str)
      @variables = Set.new
    end
    
    def parse
      body
    end

    def body
      stmts = []
      e = top_level
      while e 
        stmts.push e
        e = top_level
      end
      AST::Body.new(stmts)
    end

    def top_level
      swallow
      return nil if peek.nil? or peek.type == :END
      e = expression 0
      swallow
      e
    end

    def expression(precedence)
      lhs = atom

      loop do
        curr = peek
        break if curr.nil?

        info = curr.info
        break if info.nil?

        
        op_prec, op_assoc = info
        if op_prec < 0
          juxtaposed = true
          op_prec, op_assoc = [20, 1] # juxtaposition as AND 
          curr = Token.new(type: :STAR, value: '*')
        end

        break if op_prec < precedence

        if !juxtaposed
          next_token #swallow operator
        end
        rhs = expression op_prec+op_assoc
        lhs = operator curr, lhs, rhs
      end
      lhs
    end

    def atom
      if peek.type == :IDENT
        @variables.add(peek.value)
        AST::Variable.new(name: next_token.value)
      elsif peek.type == :LIT
        AST::Number.new(next_token.value.to_i)
      elsif peek.type == :NOT
        next_token
        AST::Call.new(function: reference('~'), args: [atom])
      elsif peek.type == :LPAREN
        next_token
        e = expression 0
        assert_token next_token, :RPAREN
        e
      else
        raise Error
      end
    end

    def operator(op, lhs, rhs)
      AST::Call.new(function: reference(op.value), args: [lhs, rhs])
    end


    def reference(id)
      AST::Variable.new(name: id)
    end
    
    def swallow
      while !peek.nil? and peek.type == :NEWLINE
        next_token
      end
    end

    def assert_token(token, *types)
      raise Exception, "unexpected type: #{token.type}" unless types.include? token.type
    end

    def token
      @current
    end

    def next_token
      #puts "advancing from #{@current.type}:#{@current.value} to #{peek.value}" unless @current.nil?
      @current = @peeked || @lexer.next_token
      @peeked = nil
      token
    end

    def peek
      @peeked ||= @lexer.next_token
    end

    def variables
      @variables.to_a
    end
  end
end
