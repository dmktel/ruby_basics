puts "Please, enter day:"
day = gets.to_i
puts "Please, enter month:"
month = gets.to_i
puts "Please, enter year:"
year = gets.to_i

days_year = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_year[1] = 29 if year % 400 == 0 || year % 4 == 0 && year % 100 != 0

num = 0
days_year[0...month - 1].each { |month| num += month }
num += day
puts num
