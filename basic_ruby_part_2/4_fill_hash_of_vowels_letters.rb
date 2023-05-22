# 4. Заполнить хеш гласными буквами,
# где значением будет являтся порядковый номер буквы в алфавите (a - 1).

vowels_arr = %w[a e i o u y]
alphabet = ('a'..'z').to_a

result_hash = {}

alphabet.length.times do |i|
  if vowels_arr.include?(alphabet[i])
    result_hash[alphabet[i]] = i+1
  end
end

puts "Хэш гласных букв и их порядковых номеров в английском алфавите:"
puts result_hash
