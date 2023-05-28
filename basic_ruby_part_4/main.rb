require_relative "station"
require_relative "route"
require_relative "train"
require_relative "carriage"

def show_menu
  puts "\nДля вас доступны следующие команды:"
  puts "\t 1 - Создать станцию"\
       "\n\t 2 - Смотреть список станций"\
       "\n\t 3 - Список поездов на станции"\
       "\n\t 4 - Создать поезд"\
       "\n\t 5 - Назначить маршрут поезду"\
       "\n\t 6 - Создать вагоны"\
       "\n\t 7 - Управление маршрутами"\
       "\n\t 8 - Перемещение поезда по маршруту"\
       "\n\t 9 - Управление вагонами поезда"\
       "\n\t 0 - завершить работу с программой"
  print 'Введите номер интересующей вас команды: '
end

def handle_response(answer)
  case answer
  when 1
    create_station
  when 2
    view_stations
  when 3
    view_trains_on_station
  when 4
    create_train
  when 5
    assign_route 
  when 6
    create_carriage
  when 7
    routes_management
  when 8
    route_moving
  when 9
    carriage_management
  end
end

def select_exist_entity(class_name)
  class_name.list.each_with_index do |entity, index|
    puts "#{index + 1}) #{entity.inspect}"
  end
  selected_index = gets.chomp.to_i - 1
  class_name.list[selected_index]
end

def create_station
  print 'Введите название станции: '
  station_name = gets.chomp.to_s
  station = Station.new(station_name).inspect
  puts "Создана станция: #{station}"
  station
end

def view_stations
  puts "\nСписок станций в системе:"
  Station.list.each{|station| puts station.name}
end

def view_trains_on_station
  puts "Выберите станцию, для которой хотите посмотреть список поездов:"
  station = select_exist_entity(Station)
  if station
    puts "\nСписок поездов на станции #{station.name}"
    station.trains.each{|train| puts train.inspect} 
  end
end

def create_train
  puts "Введите тип поезда, который вы хотите создать:"\
       "\n\t 1 - Грузовой "\
       "\n\t 2 - Пассажирский"
  train_type = gets.chomp.to_i
  print 'Введите номер поезда: '
  train_number = gets.chomp.to_i
  case train_type
  when 1
    puts "Создан грузовой поезд: #{CargoTrain.new(train_number).inspect}"
  when 2
    puts "Создан пассажирский поезд: #{PassengerTrain.new(train_number).inspect}"
  end
end

def assign_route
  puts "Выберите поезд, которому вы хотите назначить маршрут:"
  selected_train = select_exist_entity(Train)
  puts "Выберите маршрут, который вы хотите назначить поезду:"
  selected_route = select_exist_entity(Route)
  selected_train.receive_route(selected_route)
  puts "Для поезда #{selected_train}"
  puts "назначен маршрут #{selected_route}"
end

def create_carriage
  puts "Введите тип вагона, который вы хотите создать:"\
  "\n\t 1 - Грузовой "\
  "\n\t 2 - Пассажирский"
  carriage_type = gets.chomp.to_i
  case carriage_type
  when 1
    puts "Создан грузовой вагон: #{CargoCarriage.new}"
  when 2
    puts "Создан пассажирский вагон: #{PassengerCarriage.new}"
  end
end

def routes_management
  puts "Выберите интересующее вас действие:"\
  "\n\t 1 - Создать маршрут"\
  "\n\t 2 - Управлять существующим маршрутом"
  select = gets.chomp.to_i
  case select
    when 1
      create_route
    when 2
      edit_route
  end
end

def create_route
  puts "Выберите начальную станцию маршрута:"
  start_station = select_exist_entity(Station)

  puts "Выберите конечную станцию маршрута:"
  end_station = select_exist_entity(Station)

  route = Route.new(start_station, end_station)
  puts "Создан маршрут #{route.inspect}"
end

def edit_route
  puts "Выберите маршрут, которым вы хотите управлять:"
  selected_route = select_exist_entity(Route)
  puts "Выберите операцию над маршрутом #{selected_route.inspect}:"\
       "\n\t 1 - Добавить станцию"\
       "\n\t 2 - Удалить станцию"
  route_operation = gets.chomp.to_i
  case route_operation
  when 1
    puts "Выберите станцию, которую, вы хотите добавить в маршрут:"
    station_to_add = select_exist_entity(Station)
    selected_route.add_station(station_to_add)
    puts "в маршрут добавленв станция #{station_to_add.name}"
    puts "обновленный маршрут: #{selected_route.inspect}"
  when 2
    puts "Выберите станцию, которую нобходимо удалить из маршрута:"
    selected_route.stations.each_with_index do |station, index|
      puts "#{index + 1} - #{station.inspect}"
    end
    station_to_delete_index = gets.chomp.to_i - 1
    station_to_delete = selected_route.stations[station_to_delete_index]
    delete_result = selected_route.delete_station(station_to_delete)
    if delete_result
      puts "из маршрута удалена станция #{station_to_delete.name}"
      puts "обновленный маршрут: #{selected_route.inspect}"
    else
      puts "Ошибка: вы пытаетесь удалить начальную или конечную станцию маршрута"
    end
  end
end

def route_moving
  puts "Выберите поезд, который планируете переместить:"
  train = select_exist_entity(Train)
  puts "Поезд находится на станции #{train.current_station.name}"
  puts "Что нужно сделать с поездом?"\
  "\n\t 1 - Переместить вперед по маршруту"\
  "\n\t 2 - Переместить назад по маршруту"
  move_operation = gets.chomp.to_i
  case move_operation
  when 1
    if train.go_next_station
      puts "поезд #{train} перемещен вперед на 1 станцию, текущая станция = #{train.current_station.name}"
    else
      puts "Поезд не может быть перемещен вперед, так как находится на конечной станции маршрута"
    end
  when 2
    if train.go_prev_station
      puts "поезд #{train} перемещен назад на 1 станцию, текущая станция = #{train.current_station.name}"
    else
      puts "Поезд не может быть перемещен назад, так как находится на начальной станции маршрута"
    end
  end
end

def carriage_management
  puts "Выберите поезд, для изменения вагонов:"
  selected_train = select_exist_entity(Train)
  puts "Выберите операцию над поездом:"\
  "\n\t 1 - Добавить вагон "\
  "\n\t 2 - Удалить вагон"
  carriage_operation = gets.chomp.to_i
  case carriage_operation
  when 1
    puts "Выберите вагон для добавления"
    selected_carriage = select_exist_entity(Carriage)
    result = selected_train.add_wagon(selected_carriage)
    if result 
      puts "для поезда #{selected_train.inspect} добавлен вагон #{selected_carriage}"
    else
      puts "для поезда #{selected_train.inspect} вагон #{selected_carriage} не может быть добавлен"
    end
  when 2
    puts "Выберите вагон для удаления: "
    selected_train.wagons.each_with_index do |wagon, index|
      puts "#{index + 1} - #{wagon.inspect}"
    end
    wagon_to_delete_index = gets.chomp.to_i - 1
    wagon_to_delete = selected_train.wagons[wagon_to_delete_index]
    selected_train.delete_wagon(wagon_to_delete)
    puts "у поезда #{selected_train.inspect} удален вагон #{wagon_to_delete}"
  end
end

puts 'Добро пожаловать в интерфейс управления железнодорожными дорогами!'

loop do
  show_menu
  answer = gets.chomp.to_i
  break if answer == 0
  result = handle_response(answer)
end