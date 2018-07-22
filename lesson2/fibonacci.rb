fibonacci = [0]
fib = 1

while fib < 100
  fibonacci.push(fib)
  fib = fibonacci[-1] + fibonacci[-2]
end

puts fibonacci
