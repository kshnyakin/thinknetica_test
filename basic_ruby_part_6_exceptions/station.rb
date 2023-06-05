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
    unless valid?
      raise ArgumentError, 'Arguments you have passed must be present, '\
      'have Sting class and length greater or equal 3' 
    end
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

  private

  def valid?
    return if @name.class != String || @name.length <= 3
    true
  end
end