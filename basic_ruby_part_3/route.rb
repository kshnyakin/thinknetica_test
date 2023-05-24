class Route
  attr_reader :stations_list
  def initialize(start_station, end_station)
    @stations_list = [start_station, end_station]
  end

  def view_stations_list
    counter = 1
    puts "Перечень станций маршрута "
    @stations_list.each do |station|
       puts "#{counter}) #{station.name}"
       counter += 1
    end
  end

  def add_station(station_to_add, station_before_add)
    if @stations_list.include?(station_to_add)
      puts "Станция #{station_to_add.name} уже есть в маршруте"
    elsif @stations_list.include?(station_before_add) == false
      puts "Станции '#{station_before_add.name}', перед которой вы хотите добавить новую станцию в маршруте не существует."
    else
      index_to_add = @stations_list.index(station_before_add)
      return "Нельзя изменить начальную станцию маршрута" if index_to_add == 0
      @stations_list.insert(index_to_add, station_to_add)
      puts "Станция '#{station_to_add.name}' успешно добавлена в маршрут перед станцией #{station_before_add}"
      view_stations_list
    end
  end

  def delete_station(station_to_delete)
    return 'Удаление станции невозможно: в маршруте достигнуто минимальное количество станций = 2' if @stations_list.size < 3
    if @stations_list.include?(station_to_delete) == false
      puts "Станцию '#{station_to_delete.name}' нельзя удалить из маршрута, т.к. ее там нет"
    elsif
      index_to_delete = @stations_list.index(station_to_delete)
      return "Нельзя удалять начальную / конечную станцию маршрута" if index_to_delete == 0 || index_to_delete == (@stations_list.size - 1)
      @stations_list.delete(station_to_delete)
      puts "Станция '#{station_to_delete.name}' успешно удалена из маршрута"
      view_stations_list
    end
  end
end
