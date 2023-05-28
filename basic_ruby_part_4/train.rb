class Train
  attr_reader :speed, :wagons, :type
  @@object_ids = []
  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @@object_ids << self.object_id
  end

  def self.list
    @@object_ids.map{|object_id| ObjectSpace._id2ref(object_id) }
  end

  def increase_speed(growth)
    @speed += growth
  end

  def braking
    @speed = 0
  end

  def add_wagon(wagon)
    if speed == 0
      @wagons << wagon
    end
  end

  def delete_wagon(wagon)
    if speed == 0 && @wagons.size > 0
      @wagons.delete(wagon)
    end
  end

  def wagons_qty
    @wagons.size
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

class CargoTrain < Train
  def add_wagon(wagon)
    if wagon.class == CargoCarriage
      super(wagon)
    end
  end
end

class PassengerTrain < Train
  def add_wagon(wagon)
    if wagon.class == PassengerCarriage
      super(wagon)
    end
  end
end