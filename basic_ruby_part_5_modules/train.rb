require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :speed, :carriages, :type, :number
  @@trains = []

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def self.find(number)
    @@trains.find{|train| train.number == number}
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

  def carriages_quantity
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

  def go_previous_station
    if previous_station
      current_station.dispatch_train(self)
      @current_station_index -= 1
      current_station.receive_train(self)
    end
  end

  def previous_station
    if @current_station_index > 0
      @route.stations[@current_station_index - 1]
    end
  end
end

# train = Train.new('5678')
# puts "количество инстансов = #{Train.instances}"