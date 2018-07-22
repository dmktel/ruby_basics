sum = 0
sum_product = 0
cart = {}
loop do
  print "Enter product or 'stop': "
  product = gets.chomp
  break if product == "stop"
  print "Enter price: "
  price = gets.to_f
  print "Enter quantity: "
  count = gets.to_f
  cart[product] = { price: price, count: count }
end
cart.each do |product, data|
  sum_product = data[:price] * data[:count] 
  puts "#{product} price: #{data[:price]} quantity: #{data[:count]} amount: #{sum_product}"
  sum += sum_product
end

puts "Total amout: #{sum}"
