# Файл в котором происходит управление классами Station / Route / Train
require_relative "station"
require_relative "route"
require_relative "train"

puts "Проверка класса Station"
puts "======================="
train_1 = Train.new('185', 'пассажирский', 15)
train_2 = Train.new('200', 'грузовой', 50)
train_3 = Train.new('355', 'пассажирский', 16)
station_moscow = Station.new('Москва')
station_tula = Station.new('Тула')
station_serpukhov = Station.new('Серпухов')
station_tarusskaya = Station.new('Тарусская')
# Принимаем поезда на станцию
station_moscow.receive_train(train_1)
station_moscow.receive_train(train_2)
station_moscow.receive_train(train_3)

# Все поезда на станции
puts "\t* Cписок поездов на станции после принятия поездов #{station_moscow.trains}"
puts "\t* Количество пассажирских поездов на станции: #{station_moscow.trains_by_type('пассажирский')}"
puts "\t* Количество грузовых поездов на станции: #{station_moscow.trains_by_type('грузовой')}"
# отправка всех поездов со станции
station_moscow.dispatch_train(train_1)
station_moscow.dispatch_train(train_2)
station_moscow.dispatch_train(train_3)
puts "\t* Cписок поездов на станции после отправки #{station_moscow.trains}"

puts "\nПроверка класса Route"
puts "======================="
puts "создали маршрут"
route = Route.new(station_moscow, station_tula)
puts "\t* Станции маршрута начальные #{route.stations}"
puts "Добавили 2 станции в маршрут"
route.add_station(station_serpukhov)
route.add_station(station_tarusskaya)
puts "\t* Станции маршрута после добавления 2-х станций: #{route.stations}"
puts "Попытка удаления начальной / конечной станций"
route.delete_station(station_moscow)
route.delete_station(station_tula)
puts "\t* Список станций не изменился: #{route.stations}"
puts "Удаление добавленных ранее станций"
route.delete_station(station_serpukhov)
route.delete_station(station_tarusskaya)
puts "\t* Список станций после удаления: #{route.stations}"

puts "\nПроверка класса Train"
puts "======================="
train_4 = Train.new('123', 'пассажирский', 25)
puts "\t* Текущая скорость поезда: #{train_4.speed}"
puts "Набрали скорость +50"
train_4.increase_speed(50)
puts "\t* Текущая скорость поезда: #{train_4.speed}"
puts "Затормозили"
train_4.braking
puts "\t* Текущая скорость поезда: #{train_4.speed}"
puts "\t* Количество вагонов поезда: #{train_4.wagons_qty}"
puts "Добавили 2 вагона"
train_4.add_wagon
train_4.add_wagon
puts "\t* Количество вагонов поезда: #{train_4.wagons_qty}"
puts "Удалили 3 вагона"
train_4.delete_wagon
train_4.delete_wagon
train_4.delete_wagon
puts "\t* Количество вагонов поезда: #{train_4.wagons_qty}"
puts "Набрали скорость +50"
train_4.increase_speed(50)
puts "Пытаемся удалить 2 вагона"
train_4.delete_wagon
train_4.delete_wagon
puts "\t* Количество вагонов поезда: #{train_4.wagons_qty}"
puts "Пытаемся добавить 2 вагона"
train_4.add_wagon
train_4.add_wagon
puts "\t* Количество вагонов поезда: #{train_4.wagons_qty}"
train_route = Route.new(station_moscow, station_tula)
train_route.add_station(station_serpukhov)
train_route.add_station(station_tarusskaya)
train_4.receive_route(train_route)
puts "\t* Текущая станция местонахождения поезда: #{train_4.current_station.inspect}"
puts "\t* Следующая станция по маршруту поезда: #{train_4.next_station.inspect}"
puts "\t* Предыдущая станция по маршрут поезда: #{train_4.prev_station.inspect}"
puts 'Перемещаем поезд на 2 станции веперед'
train_4.go_next_station
train_4.go_next_station
puts "\t* Текущая станция местонахождения поезда: #{train_4.current_station.inspect}"
puts "\t* Следующая станция по маршруту поезда: #{train_4.next_station.inspect}"
puts "\t* Предыдущая станция по маршрут поезда: #{train_4.prev_station.inspect}"
puts 'Перемещаем поезд на 1 станцию назад'
train_4.go_prev_station
puts "\t* Текущая станция местонахождения поезда: #{train_4.current_station.inspect}"
puts "\t* Следующая станция по маршруту поезда: #{train_4.next_station.inspect}"
puts "\t* Предыдущая станция по маршрут поезда: #{train_4.prev_station.inspect}"