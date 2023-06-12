require_relative 'validator'

class CargoTrain < Train
  include Validator

  attr_reader :type
  def initialize(number)
    @type = :cargo
    super(number)
  end
end