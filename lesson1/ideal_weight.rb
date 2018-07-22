puts "What's your name?"
name = gets.chomp

puts "What is your height in cm?"
height = gets.to_i

ideal_weight = height - 110

if ideal_weight < 0 
  puts "#{name}, your weight is already ideal!"
else
  puts "#{name}, your ideal weight is #{ideal_weight}kg!"
end
