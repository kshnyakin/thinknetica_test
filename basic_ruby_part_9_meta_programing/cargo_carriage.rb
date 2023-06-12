# frozen_string_literal: true

require_relative 'validator'

# Class for creating Cargo carriages
class CargoCarriage < Carriage
  include Validator

  def initialize(volume)
    super
    @type = :cargo
    @volume = volume
    @reserved_volume = 0
    validate! unless valid?
  end

  def reserve_volume(size)
    if size > free_volume
      raise "Error: can not reserve #{size}, "\
            "avaliable to reserve volume = #{free_volume}"
    end
    @reserved_volume += size
  end

  attr_reader :reserved_volume

  def free_volume
    @volume - @reserved_volume
  end

  private

  def validate!
    errors = []
    errors << 'Cargo volume be an integer number' if @volume.class != Integer
    errors << 'Cargo volume must be greater than null' if @volume.instance_of?(Integer) && @volume < 1
    raise errors.join(', ') unless errors.empty?
  end
end
