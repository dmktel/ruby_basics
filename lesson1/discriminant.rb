puts "Let's make quadratic equation!"
print "a = "
a = gets.to_f
print "b = "
b = gets.to_f
print "c = "
c = gets.to_f

d = b**2 - 4 * a * c # Discriminant calculation

if d < 0 
  puts "No solutions"
elsif d == 0
  x = -b / (2 * a)
  puts "Equation root x = #{x}"
else
  dsqrt = Math.sqrt(d)
  x1 = (-b + dsqrt)/(2 * a)
  x2 = (-b - dsqrt)/(2 * a)
  puts "2 roots: x1 = #{x1}, x2 = #{x2}"
end
