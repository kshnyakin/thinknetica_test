# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validator'

# Class for creating railroad stations
# rubocop:disable Style/ClassVars
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

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end

  def dispatch_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }.size
  end

  private

  def validate!
    errors = []
    errors << 'Station name must be a String' if @name.class != String
    if @name.instance_of?(String) && @name.length < 3
      errors << 'Station name length must '\
                'be greater or equal 3'
    end
    raise errors.join(', ') unless errors.empty?
  end
end
# rubocop:enable Style/ClassVars
