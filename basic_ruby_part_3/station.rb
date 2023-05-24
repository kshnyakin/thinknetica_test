class Station
  attr_reader :name, :trains_on_station
  def initialize(name)
    @name = name
    @trains_on_station = {}
  end

  def receive_train(train)
    @trains_on_station[train.number] = train
  end

  def dispatch_train(train)
    @trains_on_station.delete(train.number)
  end

  def trains_list
    if trains_on_station.empty?
      puts "На станции #{@name} отсутствуют поезда"
    else
      @trains_on_station.each{|train| puts train.inspect}
    end
  end

  def trains_type_list
    freight_trains_qty = 0
    passenger_trains_qty = 0

    @trains_on_station.each do |_, train|
      train.type == 'грузовой' ? freight_trains_qty += 1 : passenger_trains_qty += 1
    end
    puts "На станции #{@name} есть поезда: грузовые #{freight_trains_qty} шт, пассажирские: #{passenger_trains_qty}"
  end
end