require_relative 'instance_counter'
require_relative 'validator'

class Station
  include InstanceCounter
  include Validator
  attr_reader :name, :trains
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    if valid?
      @@stations << self
      register_instance
    else
      validate!
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

  def validate!
    errors = []
    errors << 'Station name must be a String' if @name.class != String
    errors << 'Station name length must '\
              'be greater or equal 3' if @name.class == String && @name.length <= 3
    raise errors.join(', ') unless errors.empty?
  end
end