class Train
  attr_reader :current_speed, :wagons_qty, :number, :type
  def initialize(number, type, wagons_qty)
    @number = number.to_s
    @type = type.downcase
    @wagons_qty = wagons_qty
    @current_speed = 0
    puts "Успешно создан поезд №#{number}, тип: #{type}, количество вагонов: #{wagons_qty}"
  end

  def increase_speed(growth)
    @current_speed += growth
    puts "Скорость поезда увеличена на #{growth} км/ч и составляет #{@current_speed} км/ч"
  end

  def braking
    @current_speed = 0
    puts "Поезд успешно снизил скорость до 0"
  end

  def add_wagon
    if @current_speed == 0
      @wagons_qty += 1
      puts "К поезду успешно прицеплен 1 вагон, общее количество вагонов: #{wagons_qty}"
    else
      puts "Ошибка, отцепка вагона невозможна, поезд находится в движении"
    end
  end

  def delete_wagon
    if @current_speed == 0 && @wagons_qty > 0
      @wagons_qty -= 1
      puts "От поезда успешно отцеплен 1 вагон, общее количество вагонов: #{wagons_qty}"
    else
      puts "Ошибка, отцепка вагона невозможна, поезд находится в движении или не осталось вагонов для отцепки"
    end
  end

  def receive_route(route)
    @route = route
    @current_station = route.stations_list[0]
  end

  def show_current_station
    puts "Текущая станция поезда №#{@number} = #{@current_station.name}"
    @current_station
  end

  def show_next_station
    stations_list = @route.stations_list
    if current_station_index == stations_list.size - 1
      puts 'Поезд уже находится на конечной станции маршрута'
    else
      next_station = stations_list[current_station_index + 1]
      puts "Следующая станция '#{next_station.name}'"
      next_station
    end
  end

  def show_prev_station
    if current_station_index == 0
      puts 'Поезд уже находится на начальной станции маршрута'
    else
      prev_station = @route.stations_list[current_station_index - 1]
      puts "Предыдущая станция '#{prev_station.name}'"
      prev_station
    end
  end

  def move_on_next_station
    stations_list = @route.stations_list
    if current_station_index == stations_list.size - 1
      puts "Поезд находится на конечной станции маршрута и не может двигаться вперед"
    else
      next_station = stations_list[current_station_index + 1]
      @current_station = next_station
      puts "Поезд успешно переехал на слудующую станцию маршрута - #{next_station.name}"
    end
  end

  def move_on_prev_station
    if current_station_index == 0
      puts "Поезд находится на начальной станции маршрута и не может двигаться назад"
    else
      prev_station = @route.stations_list[current_station_index - 1]
      @current_station = prev_station
      puts "Поезд успешно переехал на предыдущую станцию маршрута - #{prev_station.name}"
    end
  end

  private
  def current_station_index
    @route.stations_list.index(@current_station)
  end
end

