# Квадратное уравнение
print 'Пожалуйста, введите коэффициент [a] квадратного уравнения: '
a_coeff = gets.chomp.to_f

print 'Пожалуйста, введите коэффициент [b] квадратного уравнения: '
b_coeff = gets.chomp.to_f

print 'Пожалуйста, введите коэффициент [c] квадратного уравнения: '
c_coeff = gets.chomp.to_f

def calc_desc(a_coeff, b_coeff, c_coeff)
  b_coeff**2 - 4 * a_coeff * c_coeff
end

def calc_roots(descriminant, a_coeff, b_coeff)
  if descriminant == 0
    x1_x2 = -b_coeff / (2 * a_coeff)
    "x1 = x2 = #{x1_x2}"
  else
    x1 = (-b_coeff - Math.sqrt(descriminant)) / (2*a_coeff)
    x2 = (-b_coeff + Math.sqrt(descriminant)) / (2*a_coeff)
    "x1 = #{x1}, x2 = #{x2}"
  end

end

descriminant = calc_desc(a_coeff, b_coeff, c_coeff)

if descriminant < 0
  puts 'Корней нет'
else
  puts "Дескриминант = #{descriminant}, #{calc_roots(descriminant, a_coeff, b_coeff)}"
end
