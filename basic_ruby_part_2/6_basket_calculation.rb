# 6. Сумма покупок

basket = {}

loop do
  print 'Введите название товара: '
  product = gets.chomp
  break if product.downcase == 'стоп'
  if basket[product.to_sym]
    puts "Продукт <#{product}> уже в вашей корзине!"
    next
  end
  print 'Введите цену за единицу товара (например, 25.5): '
  price = gets.chomp.gsub(',','.').to_f
  print 'Введите количество товара (например, 10.5): '
  quantity = gets.chomp.gsub(',','.').to_f

  cost = (price * quantity).round(2)
  basket[product.to_sym] = {
    price: price,
    quantiy: quantity,
    cost: cost
  }
  puts "\t В список покупок успешно добавлен товар "\
      "<#{product}> по цене (#{price}) в количестве (#{quantity}) на общую сумму (#{cost})"
end

puts "\nИтоговый хэш ваших покупок:"
pp basket

def basket_show(basket)
  
  counter = 1
  total_cost = 0.0
  basket.each do |key, value|
    puts "#{counter}) #{key.to_s} на сумму #{value[:cost]} у.е."
    total_cost += value[:cost]
    counter += 1
  end
  puts "\nИтоговая стоимость: #{total_cost.round(2)} у.е."
end

puts "\n\tСписок покупок с указанием стоимости"
basket_show(basket)