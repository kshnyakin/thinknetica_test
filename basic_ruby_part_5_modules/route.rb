require_relative 'instance_counter'

class Route
  include InstanceCounter
  attr_reader :stations
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instance
  end

  def add_station(station_to_add)
    stations.insert(-2, station_to_add)
  end

  def delete_station(station_to_delete)
    if station_to_delete != stations[0] && station_to_delete != stations[-1]
      stations.delete(station_to_delete)
    end
  end
end