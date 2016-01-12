module Lang
  module Builtins
    def *(args)
      args[0].eval(self) & args[1].eval(self)
    end

    def +(args) 
      args[0].eval(self) | args[1].eval(self)
    end

    def ~(args)
      ~args[0].eval(self) & 1
    end

    def evaluate(args)
      args.map{|x| x.eval(self)}
    end
  end
end
