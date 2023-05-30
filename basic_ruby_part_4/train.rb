class Train
  attr_reader :speed, :carriages, :type
  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
  end

  def increase_speed(growth)
    @speed += growth
  end

  def braking
    @speed = 0
  end

  def add_carriage(carriage)
    if speed == 0 && type == carriage.type
      @carriages << carriage
    end
  end

  def delete_carriage(carriage)
    if speed == 0 && @carriages.size > 0
      @carriages.delete(carriage)
    end
  end

  def carriages_qty
    @carriages.size
  end

  def receive_route(route)
    @route = route
    @current_station_index = 0
    route.stations[0].receive_train(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def go_next_station
    if next_station
      current_station.dispatch_train(self)
      @current_station_index += 1
      current_station.receive_train(self)
    end
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def go_prev_station
    if prev_station
      current_station.dispatch_train(self)
      @current_station_index -= 1
      current_station.receive_train(self)
    end
  end

  def prev_station
    if @current_station_index > 0
      @route.stations[@current_station_index - 1]
    end
  end
end