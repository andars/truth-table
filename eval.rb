#!/usr/bin/env ruby
require_relative 'ast'
require_relative 'token'
require_relative 'lexer'
require_relative 'parser'
require_relative 'context'

input = STDIN.readlines
expressions = input.map do |expr|
  parser = Lang::Parser.new(expr)
  ast = parser.parse
  [parser.variables.sort, ast, expr]
end

puts

def indented(str)
  puts "  " + str
end

outputs = []

expressions.each do |expr|
  puts

  vars, ast, expr_text = expr
  output = []

  puts "f(#{vars.join(', ')}):"
  puts

  #generate table header

  header = vars.join(' ') + " | " + expr_text 
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
    output << ast.eval(ctx)
    row += " | " + ast.eval(ctx).to_s
    indented row
  end
  outputs << output
end

equal = true

expressions[0][0].length.times do |i|
  first = outputs[0][i]
  outputs.each do |o|
    if o[i] != first
      equal = false
      break
    end
  end
end


puts "The expressions are #{equal ? "" : "not "}equal" if expressions.length > 1
