#!/usr/bin/env ruby
require_relative 'ast'
require_relative 'token'
require_relative 'lexer'
require_relative 'parser'
require_relative 'context'

expressions = STDIN.readlines
data = expressions.map do |expr|
  parser = Lang::Parser.new(expr)
  ast = parser.parse
  [parser.variables.sort, ast, expr]
end
puts "-"*10
puts "Detected Variables:"
data.each do |datum|
  puts " #{datum[0]}"
end

puts "-"*10


def indented(str)
  puts str
end

#generate table header

data.each do |datum|
  2.times { puts } 

  vars, ast, expr = datum

  header = vars.join(' ') + " | " + expr 
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
end
