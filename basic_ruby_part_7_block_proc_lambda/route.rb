require_relative 'instance_counter'
require_relative 'validator'

class Route
  include InstanceCounter
  include Validator
  attr_reader :stations
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    valid? ? register_instance : validate!
  end

  def add_station(station_to_add)
    stations.insert(-2, station_to_add)
  end

  def delete_station(station_to_delete)
    if station_to_delete != stations[0] && station_to_delete != stations[-1]
      stations.delete(station_to_delete)
    end
  end

  private

  def validate!
    errors = []
    errors << 'Arguments you have passed is not a Station class!' unless passed_stations?
    raise errors.join(', ') unless errors.empty?
  end

  def passed_stations?
    @stations[0].class == Station && @stations[1].class == Station
  end
end