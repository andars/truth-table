#!/usr/bin/env ruby
require_relative 'ast'
require_relative 'token'
require_relative 'lexer'
require_relative 'parser'
require_relative 'context'

expression = STDIN.read
parser = Lang::Parser.new(expression)
ast = parser.parse
puts "-"*10
puts "Detected Variables:"
vars = parser.variables.sort
puts " #{vars}"
puts "-"*10


def indented(str)
  puts str
end

#generate table header

5.times { puts } 

header = vars.join(' ') + " | " + expression
indented header
indented "-"*10

#generate table body
(0..2**vars.length-1).each do |i|
  ctx = Lang::Context.new
  row = ("%0#{vars.length}b" % i).split('').join(' ')
  (0..vars.length-1).to_a.reverse.each do |j|
    ctx.set(vars[j].to_sym, i%2)
    i = i/2
  end
  row += " | " + ast.eval(ctx).to_s
  indented row
end
