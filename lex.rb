require_relative 'token'
require_relative 'lexer'
lexer = Lang::Lexer.new(STDIN.read)
tok = lexer.next_token
while tok
	puts "#{tok.type}, #{tok.value}"
	tok = lexer.next_token
end
