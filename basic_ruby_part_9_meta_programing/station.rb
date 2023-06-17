# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

# Class for creating railroad stations
# rubocop:disable Style/ClassVars
class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains

  @@stations = []

  validate :name, :length, 3
  validate :name, :presence
  validate :name, :type, String

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
end
# rubocop:enable Style/ClassVars
