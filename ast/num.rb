module Lang::AST
  class Number < Base

    def initialize(val)
      @value = val
    end

    def eval(context)
      @value
    end
  end
end
