# frozen_string_literal: true

require_relative 'validator'

# Class for creating Passenger carriages
class PassengerCarriage < Carriage
  include Validator

  def initialize(seats)
    super
    @type = :passenger
    @seats = seats
    @reserved_seats = 0
    validate! unless valid?
  end

  def reserve_seat
    raise 'Error: can not reserve seat, all seats are reserved' if free_seats.zero?

    @reserved_seats += 1
  end

  attr_reader :reserved_seats

  def free_seats
    @seats - @reserved_seats
  end

  def validate!
    errors = []
    errors << 'Number of seats must be an integer number' if @seats.class != Integer
    errors << 'Number of seats must be greater then null' if @seats.instance_of?(Integer) && @seats < 1
    raise errors.join(', ') unless errors.empty?
  end
end
