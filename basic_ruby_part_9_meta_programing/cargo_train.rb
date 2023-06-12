# frozen_string_literal: true

require_relative 'validator'

# Class for creating Cargo trains
class CargoTrain < Train
  include Validator

  attr_reader :type

  def initialize(number)
    @type = :cargo
    super(number)
  end
end
