module Lang
  module AST
    class Base
      def initialize
      end
    end
    Dir.glob "ast/*" do |f|
      require_relative f
    end
  end
end
