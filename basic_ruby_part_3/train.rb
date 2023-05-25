class Train
  attr_reader :speed, :wagons_qty, :type
  def initialize(number, type, wagons_qty)
    @number = number
    @type = type.downcase
    @wagons_qty = wagons_qty
    @speed = 0
  end

  def increase_speed(growth)
    @speed += growth
  end

  def braking
    @speed = 0
  end

  def add_wagon
    if speed == 0
      @wagons_qty += 1
    end
  end

  def delete_wagon
    if speed == 0 && wagons_qty > 0
      @wagons_qty -= 1
    end
  end

  def receive_route(route)
    @route = route
    @current_station_index = 0
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def go_next_station
    @current_station_index += 1 if next_station
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def go_prev_station
    @current_station_index -= 1 if prev_station
  end

  def prev_station
    if @current_station_index > 0
      @route.stations[@current_station_index - 1]
    end
  end
end

