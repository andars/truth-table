module Lang::AST
  class Variable
    attr_accessor :name

    def initialize(name: )
      @name = name
    end

    def eval(context)
      context.get(name)
    end
  end
end
