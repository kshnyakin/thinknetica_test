# Площадь треугольника

print 'Пожалуйста, введите длину основания треугольника в метрах: '
triangle_base_length = gets.chomp.to_f

print 'Пожалуйста, введите длину высоты треугольника в метрах: '
triangle_height_length = gets.chomp.to_f

triangle_square = ((triangle_base_length * triangle_height_length) / 2).round(3)

puts "Площадь треугольника составляет #{triangle_square} m2"