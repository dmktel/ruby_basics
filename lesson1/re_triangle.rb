puts "Let's know what kind of triangle we have!"
puts "Please, enter 'a' side:"
a = gets.to_f
puts "Please, enter 'b' side:"
b = gets.to_f
puts "Please, enter 'c' side:"
c = gets.to_f

hip = [a,b,c].max
cat1, cat2 = [a,b,c].min(2)
rectangular = hip**2 == cat1**2 + cat2**2
if rectangular && cat1 == cat2
  puts "Triangle is rectangular and isosceles"
elsif rectangular 
  puts "Triangle is rectangular"
else
  puts "Triangle is nonrectangular"
end
