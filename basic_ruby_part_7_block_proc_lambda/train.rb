require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validator'

class Train
  include Manufacturer
  include InstanceCounter
  include Validator
  attr_reader :speed, :carriages, :type, :number
  @@trains = []

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    if valid?
      @@trains << self
      register_instance
    else
      validate!
    end    
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

  def each_carriage(&block)
    @carriages.each {|carriage| block.call(carriage)}
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

  private

  def validate!
    errors = []
    errors << 'Number of train must be a String' if @number.class != String
    errors << 'Number of train must be eqaul to regular expression '\
              'like 222-aaa / bbb-22 / 444ff / fff44 and etc' if regexp_failed?
    raise errors.join(', ') unless errors.empty?
  end

  def regexp_failed?
    regexp = /^([a-zа-я]{3}|[0-9]{3})-?([a-zа-я]{2}|[0-9]{2})$/i
    (@number =~ regexp).nil?
  end
end