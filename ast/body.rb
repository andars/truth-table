module Lang::AST
  class Body < Base
    attr_accessor :statements

    def initialize(statements)
      @statements = statements
    end

    def eval(context)
      s = statements.map do |s|
        s.eval(context)
      end
      s.last
    end
  end
end
