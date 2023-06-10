require_relative 'validator'

class PassengerCarriage < Carriage
  include Validator

  def initialize(seats)
    @type = :passenger
    @seats = seats
    @reserved_seats = 0
    validate! unless valid?
  end

  def reserve_seat
    @reserved_seats += 1 if @reserved_seats < @seats
  end

  def reserved_seats
    @reserved_seats
  end

  def free_seats
    @seats - @reserved_seats
  end

  def validate!
    errors = []
    errors << 'Number of seats must be an integer number' if @seats.class != Integer
    errors << 'Number of seats must be greater then null' if @seats.class == Integer && @seats < 1
    raise errors.join(', ') unless errors.empty?
  end
end