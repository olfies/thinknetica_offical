# frozen_string_literal: false

cart = {}
sum = 0

loop do
  print 'Введите название товара(или стоп): '
  item = gets.chomp
  break if item == 'стоп'

  print 'Введите название товара: '
  cost = gets.to_f
  print 'Введите цену товара: '
  amount = gets.to_f
  cart[item] = { cost: cost, amount: amount, item_sum: cost * amount }
end

cart.each do |item_name, properties|
  puts "#{item_name}, cost per unit: #{properties[:cost]}, sub_total: #{properties[:item_sum]}"
  sum += properties[:item_sum]
end
puts "Сумма вашей покупки составит: ₽#{sum} "
