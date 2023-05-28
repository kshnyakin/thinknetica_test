class Route
  attr_reader :stations
  @@object_ids = []
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    @@object_ids << self.object_id
  end

  def self.list
    @@object_ids.map{|object_id| ObjectSpace._id2ref(object_id) }
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