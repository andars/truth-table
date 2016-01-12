module Lang
  class Token
    attr_accessor :type, :value

    def initialize(type:, value:)
      @type = type
      @value = value
      @info = {}
      @info[:PLUS] = [10, 1]
      @info[:STAR] = [20, 1]
      @info[:IDENT] = [-1, 0] #juxtaposition
      @info[:LPAREN] = [-1, 0] #juxtaposition
    end

    def info
      @info[type]
    end
  end
end
