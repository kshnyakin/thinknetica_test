# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

# Main class for interactive interface
# rubocop:disable Metrics/ClassLength
class Main
  def initialize
    @carriages = []
    @routes = []
    @stations = []
    @trains = []
  end

  def start
    puts 'Добро пожаловать в интерфейс управления железнодорожными дорогами!'
    loop do
      show_menu
      action_number = read_action
      break if action_number.zero?

      launch_process(action_number)
    end
  end

  private

  attr_reader :stations, :routes, :trains, :carriages

  # rubocop:disable Metrics/MethodLength
  def show_menu
    puts "\nДля вас доступны следующие команды:"
    puts "\t 1 - Создать станцию"\
         "\n\t 2 - Смотреть список станций"\
         "\n\t 3 - Создать поезд"\
         "\n\t 4 - Управление маршрутами"\
         "\n\t 5 - Назначить маршрут поезду"\
         "\n\t 6 - Перемещение поезда по маршруту"\
         "\n\t 7 - Список поездов на станции"\
         "\n\t 8 - Создать вагоны"\
         "\n\t 9 - Управление вагонами поезда"\
         "\n\t 0 - завершить работу с программой"
  end
  # rubocop:enable Metrics/MethodLength

  def read_action
    print "\n\tВведите номер интересующей вас команды: "
    gets.chomp.to_i
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  def launch_process(key)
    case key
    when 1
      create_station
    when 2
      view_stations
    when 3
      create_train
    when 4
      routes_management
    when 5
      assign_route
    when 6
      route_moving
    when 7
      view_trains_on_station
    when 8
      create_carriage
    when 9
      carriage_management
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength

  def select_exist_entity(list_name)
    list = send(list_name)
    list.each_with_index do |entity, index|
      puts "#{index + 1}) #{entity.inspect}"
    end
    selected_index = gets.chomp.to_i - 1
    list[selected_index]
  end

  def create_station
    print 'Введите название станции: '
    station_name = gets.chomp.to_s
    station = Station.new(station_name)
    puts "Создана станция: #{station.inspect}"
    @stations << station
  end

  def view_stations
    puts "\nСписок станций в системе:"
    stations.each { |station| puts station.name }
  end

  def create_train
    train_type, train_number = prepare_train_creation
    begin
      handle_train_type(train_type, train_number)
    rescue ArgumentError => e
      puts "Error: #{e.message}"
    ensure
      create_train if e
    end
  end

  def prepare_train_creation
    question = 'Введите тип поезда, который вы хотите создать'
    answers = %w[Грузовой Пассажирский]
    train_type = get_and_validate_answers(question, answers)
    print 'Введите номер поезда: '
    train_number = gets.chomp.to_s
    [train_type, train_number]
  end

  def handle_train_type(train_type, train_number)
    case train_type
    when 1
      cargo_train = CargoTrain.new(train_number)
      @trains << cargo_train
      puts "Создан грузовой поезд № #{cargo_train.number}"
    when 2
      passenger_train = PassengerTrain.new(train_number)
      @trains << passenger_train
      puts "Создан пассажирский поезд № #{passenger_train.number}"
    end
  end

  def routes_management
    question = 'Выберите интересующее вас действие'
    answers = ['Создать маршрут', 'Управлять существующим маршрутом']
    select = get_and_validate_answers(question, answers)
    case select
    when 1
      create_route
    when 2
      edit_route
    end
  end

  def create_route
    puts 'Выберите начальную станцию маршрута:'
    start_station = select_exist_entity(:stations)

    puts 'Выберите конечную станцию маршрута:'
    end_station = select_exist_entity(:stations)

    route = Route.new(start_station, end_station)
    @routes << route
    puts "Создан маршрут #{route.inspect}"
  end

  def edit_route
    selected_route, question, answers = prepare_route_edit
    route_operation = get_and_validate_answers(question, answers)
    case route_operation
    when 1
      add_station_to_route(selected_route)
    when 2
      delete_station_from_route(selected_route)
    end
  end

  def prepare_route_edit
    puts 'Выберите маршрут, которым вы хотите управлять:'
    selected_route = select_exist_entity(:routes)
    question = "Выберите операцию над маршрутом #{selected_route.inspect}:"
    answers = ['Добавить станцию', 'Удалить станцию']
    [selected_route, question, answers]
  end

  def add_station_to_route(selected_route)
    puts 'Выберите станцию, которую, вы хотите добавить в маршрут:'
    station_to_add = select_exist_entity(:stations)
    selected_route.add_station(station_to_add)
    puts "в маршрут добавлена станция #{station_to_add.name}"
    puts "обновленный маршрут: #{selected_route.inspect}"
  end

  def delete_station_from_route(selected_route)
    puts 'Выберите станцию, которую нобходимо удалить из маршрута:'
    selected_route.stations.each_with_index do |station, index|
      puts "#{index + 1} - #{station.inspect}"
    end
    station_to_delete_index = gets.chomp.to_i - 1
    station_to_delete = selected_route.stations[station_to_delete_index]
    delete_result = selected_route.delete_station(station_to_delete)
    handle_delete_station(delete_result)
  end

  def handle_delete_station(delete_result)
    if delete_result
      puts "из маршрута удалена станция #{station_to_delete.name}"
      puts "обновленный маршрут: #{selected_route.inspect}"
    else
      puts 'Ошибка: вы пытаетесь удалить начальную или конечную станцию маршрута'
    end
  end

  def assign_route
    puts 'Выберите поезд, которому вы хотите назначить маршрут:'
    selected_train = select_exist_entity(:trains)
    puts 'Выберите маршрут, который вы хотите назначить поезду:'
    selected_route = select_exist_entity(:routes)
    selected_train.receive_route(selected_route)
    puts "Для поезда #{selected_train.inspect}"
    puts "назначен маршрут #{selected_route.inspect}"
  end

  def route_moving
    move_operation = select_train_and_operation
    case move_operation
    when 1
      handle_next_station(train)
    when 2
      handle_previous_station(train)
    end
  end

  def select_train_and_operation
    puts 'Выберите поезд, который планируете переместить:'
    train = select_exist_entity(:trains)
    puts "Поезд находится на станции #{train.current_station.name}"
    question = 'Что нужно сделать с поездом?'
    answers = ['Переместить вперед по маршруту', 'Переместить назад по маршруту']
    get_and_validate_answers(question, answers)
  end

  def handle_next_station
    if train.go_next_station
      puts "поезд #{train} перемещен вперед на 1 станцию, текущая станция = #{train.current_station.name}"
    else
      puts 'Поезд не может быть перемещен вперед, так как находится на конечной станции маршрута'
    end
  end

  def handle_previous_station
    if train.go_previous_station
      puts "поезд #{train} перемещен назад на 1 станцию, текущая станция = #{train.current_station.name}"
    else
      puts 'Поезд не может быть перемещен назад, так как находится на начальной станции маршрута'
    end
  end

  def view_trains_on_station
    puts 'Выберите станцию, для которой хотите посмотреть список поездов:'
    station = select_exist_entity(:stations)
    return unless station

    trains_iteration_output(station)
  end

  def trains_iteration_output(station)
    puts "\nСписок поездов на станции #{station.name}"
    counter = 1
    station.each_train do |train|
      puts "#{counter}) Поезд №#{train.number}, "\
            "тип: #{carriage_or_train_type_string(train.type)}, "\
            "количество вагонов: #{train.carriages_quantity}"
      counter += 1
    end
  end

  def create_carriage
    question = 'Введите тип вагона, который вы хотите создать:'
    answers = %w[Грузовой Пассажирский]
    carriage_type = get_and_validate_answers(question, answers)
    case carriage_type
    when 1
      create_carriage_by_type(:cargo)
    when 2
      create_carriage_by_type(:passenger)
    end
  end

  def create_carriage_by_type(type)
    created_carriage = case type
                       when :cargo
                         create_cargo_train
                       when :passenger
                         create_passenger_train
                       end
    @carriages << created_carriage
    puts "Создан вагон (тип: #{carriage_or_train_type_string(type)}): #{created_carriage}"
  end

  def create_cargo_train
    print 'Введите объем вагона (целое число): '
    volume = gets.chomp.to_i
    CargoCarriage.new(volume)
  end

  def create_passenger_train
    print 'Введите количество мест в вагоне (целое число): '
    seats = gets.chomp.to_i
    PassengerCarriage.new(seats)
  end

  def carriage_or_train_type_string(type)
    case type
    when :passenger
      'пассажирский'
    when :cargo
      'грузовой'
    end
  end

  def carriage_management
    puts 'Выберите интересующий вас поезд:'
    selected_train = select_exist_entity(:trains)
    question = 'Выберите операцию над поездом:'
    answers = ['Добавить вагон', 'Удалить вагон', 'Список вагонов', 'Занять вагон']
    carriage_operation = get_and_validate_answers(question, answers)
    carriage_operations_routing(carriage_operation, selected_train)
  end

  def carriage_operations_routing(carriage_operation, selected_train)
    case carriage_operation
    when 1
      add_carriage(selected_train)
    when 2
      delete_carriage(selected_train)
    when 3
      carriages_list(selected_train)
    when 4
      reserve_carriage(selected_train)
    end
  end

  def add_carriage(selected_train)
    puts 'Выберите вагон для добавления'
    selected_carriage = select_exist_entity(:carriages)
    result = selected_train.add_carriage(selected_carriage)
    if result
      puts "для поезда #{selected_train.inspect} добавлен вагон #{selected_carriage}"
    else
      puts "для поезда #{selected_train.inspect} вагон #{selected_carriage} не может быть добавлен, "\
           'т.к. он другого типа или поезд не остановлен'
    end
  end

  def delete_carriage(selected_train)
    puts 'Выберите вагон для удаления: '
    selected_train.carriages.each_with_index do |carriage, index|
      puts "#{index + 1} - #{carriage.inspect}"
    end
    carriage_to_delete_index = gets.chomp.to_i - 1
    carriage_to_delete = selected_train.carriages[carriage_to_delete_index]
    selected_train.delete_carriage(carriage_to_delete)
    puts "у поезда #{selected_train.inspect} удален вагон #{carriage_to_delete}"
  end

  def carriages_list(selected_train)
    puts "Список вагонов поезда № #{selected_train.number}:"
    case selected_train.type
    when :cargo
      view_cargo_carriages(selected_train, 'грузовой')
    when :passenger
      view_passenger_carriages(selected_train, 'пассажирский')
    end
  end

  def view_cargo_carriages(selected_train, type)
    counter = 1
    selected_train.each_carriage do |carriage|
      puts "\tВагон №#{counter}. тип вагона: #{type}, "\
           "объем вагона: свободно = #{carriage.free_volume}, "\
           "занято = #{carriage.reserved_volume}"
      counter += 1
    end
  end

  def view_passenger_carriages(selected_train, type)
    counter = 1
    selected_train.each_carriage do |carriage|
      puts "\tВагон №#{counter}. тип вагона: #{type}, "\
           "места: свободно = #{carriage.free_seats}, "\
           "занято = #{carriage.reserved_seats}"
      counter += 1
    end
  end

  def reserve_carriage(selected_train)
    question = 'Выберите вагон поезда для заполнения: '
    answers = []
    selected_train.each_carriage do |carriage|
      answers << "тип: #{carriage.type} (id = #{carriage.object_id})"
    end
    selected_carriage_index = get_and_validate_answers(question, answers) - 1
    selected_carriage = selected_train.carriages[selected_carriage_index]
    launching_reserving_process(selected_carriage)
  end

  def launching_reserving_process(selected_carriage)
    case selected_carriage.type
    when :passenger
      reserve_passenger_carriage(selected_carriage)
    when :cargo
      reserve_cargo_carriage(selected_carriage)
    end
  end

  def reserve_passenger_carriage(selected_carriage)
    selected_carriage.reserve_seat
  rescue StandardError => e
    puts e.message
  end

  def reserve_cargo_carriage(selected_carriage)
    print 'Введите объем загрузки: '
    load_volume = gets.chomp.to_i
    selected_carriage.reserve_volume(load_volume)
  rescue StandardError => e
    puts e.message
  end

  def get_and_validate_answers(question, answers)
    action_number = nil
    puts "\n#{question}:"
    answers.each_index { |index| puts "#{index.to_i + 1}. #{answers[index]}" }
    action_number = read_action
    # binding.pry
    raise unless (1..answers.size).to_a.include? action_number

    action_number
  rescue StandardError
    puts "\n\tПожалуйста, повторите ввод, вы ввели неверные данные"
    retry
  end
end
# rubocop:enable Metrics/ClassLength

Main.new.start
