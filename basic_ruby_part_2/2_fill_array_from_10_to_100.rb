# 2. Заполнить массив числами от 10 до 100 с шагом 5
arr = []
element = 10
while element < 101
  arr.push element
  element += 5
end

puts 'Результирующий массив:'
puts arr.inspect