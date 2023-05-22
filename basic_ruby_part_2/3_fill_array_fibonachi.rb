# 3. Заполнить массив числами фибоначчи до 100
fib_arr = []
number = 0

loop do
  fib_arr.push(number)
  if number < 2
    number += 1
  else
    number = fib_arr[-1] + fib_arr[-2]
  end
  break if number > 100
end

puts 'Массив чисел Фбоначчи до 100:'
puts fib_arr.inspect