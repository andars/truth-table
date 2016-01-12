require_relative 'builtins'

module Lang
  class Context

    include Lang::Builtins

    def initialize
      @env = {}
      Lang::Builtins.instance_methods.each do |sym|
        @env[sym] = method sym
      end
    end

    def get(name)
      if name.is_a? String
        name = name.to_sym
      end
      value = @env[name]
      if value.nil?
        raise Exception, "undefined variable #{name} in current scope"
      end
      value
    end

    def set(name, val)
      @env[name] = val
    end

    def remove(name)
      @env.delete name
    end
  end
end
