# frozen_string_literal: true

require_relative 'validation'

# Class for creating Passenger carriages
class PassengerCarriage < Carriage
  include Validation

  attr_reader :reserved_seats

  validate :seats, :presence
  validate :seats, :type, Integer
  validate :seats, :min, 1

  # rubocop:disable Lint/MissingSuper
  def initialize(seats)
    @type = :passenger
    @seats = seats
    @reserved_seats = 0
    validate! unless valid?
  end
  # rubocop:enable Lint/MissingSuper

  def reserve_seat
    raise 'Error: can not reserve seat, all seats are reserved' if free_seats.zero?

    @reserved_seats += 1
  end

  def free_seats
    @seats - @reserved_seats
  end
end
