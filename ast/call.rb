module Lang::AST
  class Call < Base
    attr_accessor :function, :args
    def initialize(function:, args:)
      @function = function
      @args = args
    end

    def eval(context)
      function.eval(context).(args)#.map{ |arg| arg.eval(context)})
    end
  end
end

