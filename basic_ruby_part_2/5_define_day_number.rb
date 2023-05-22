# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
# (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) 
# Алгоритм опредления високосного года: docs.microsoft.com

print 'Введите число: '
day = gets.chomp.to_i

print 'Введите номер месяца: '
month = gets.chomp.to_i

print 'Введите год: '
year = gets.chomp.to_i

def year_leap?(year)
  if year % 4 == 0
    if year % 100 == 0
      true
    else
      if year % 400
        true
      else
        false
      end
    end
  else
    false
  end
end

def months_hash(year)
  feb_days = year_leap?(year) ? 29 : 28
  {
    1 => { name: 'january', days: 31},
    2 => { name: 'february', days: feb_days},
    3 => { name: 'march', days: 31},
    4 => { name: 'april', days: 30},
    5 => { name: 'may', days: 31},
    6 => { name: 'june', days: 30},
    7 => { name: 'july', days: 31},
    8 => { name: 'august', days: 31},
    9 => { name: 'september', days: 30},
    10 => { name: 'october', days: 31},
    11 => { name: 'november', days: 30},
    12 => { name: 'december', days: 31}
  }
end

def calculate_days(day, month, year)
  if month == 1
    day
  else
    months_hash = months_hash(year)
    full_month_days = 0
    month_number = 1
    loop do
      full_month_days += months_hash[month_number][:days]
      month_number += 1
      break if month_number == month
    end
    full_month_days + day
  end
end

result = calculate_days(day, month, year)
puts "Вы запросили порядковый номер дня для даты: #{day}.#{month}.#{year}"
puts "Результат обработки, дата #{day}.#{month}.#{year} является днем с порядковым номером = #{result}"