# Прямоугольный треугольник

print 'Пожалуйста, введите длину первой стороны треугольника в метрах: '
first_side = gets.chomp.to_f

print 'Пожалуйста, введите длину второй стороны треугольника в метрах: '
second_side = gets.chomp.to_f

print 'Пожалуйста, введите длину третьей стороны треугольника в метрах: '
third_side = gets.chomp.to_f

def equilateral_triangle?(first_side, second_side, third_side)
  first_side == second_side && second_side == third_side
end

def pythagorean_theorem? (first_side, second_side, third_side)
  arr_sides = [first_side, second_side, third_side].sort
  hypotenuse = arr_sides.max
  side_1 = arr_sides[0]
  side_2 = arr_sides[1]
  hypotenuse ** 2 == side_1 ** 2 + side_2 ** 2
end

sides_list = "#{first_side} / #{second_side} / #{third_side}"


if equilateral_triangle?(first_side, second_side, third_side)
  puts "Треугольник со сторонами: #{sides_list} является равнобедренным и равносторонним"
elsif pythagorean_theorem?(first_side, second_side, third_side)
  puts "Треугольник со сторонами: #{sides_list} является прямоугольным"
else
  puts "Треугольник со сторонами: #{sides_list} "\
  "не является ни прямоугольным, ни равнобедренным, ни равносторонним"
end