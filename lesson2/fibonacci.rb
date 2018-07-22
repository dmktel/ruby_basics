fibonacci = [0, 1]

loop do
  fib = fibonacci[-1] + fibonacci[-2]
  break if fib >= 100
  fibonacci.push(fib)
end
puts fibonacci
