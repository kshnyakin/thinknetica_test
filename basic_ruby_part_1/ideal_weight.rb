# Идеальный вес

print 'Пожалуйста, введите ваше имя: '
user_name = gets.chomp

print 'Пожалуйста, введите свой рост в см: '
user_height = gets.chomp.to_i

ideal_weight = ((user_height - 110) * 1.15).round(3)

if ideal_weight > 0
  puts "#{user_name}, ваш иделальный вес = #{ideal_weight} кг"
else
  puts 'Ваш вес уже оптимальный'
end