# frozen_string_literal: true

# Class for creating Passenger train
class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    @type = :passenger
    super(number)
  end
end
