require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end
  
  def receive_train(train)
    trains << train
  end

  def dispatch_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select{|train| train.type == type}.size
  end
end