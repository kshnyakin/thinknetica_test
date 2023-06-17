# frozen_string_literal: true

require_relative 'validation'

# Class for creating Cargo carriages
class CargoCarriage < Carriage
  include Validation

  validate :volume, :presence
  validate :volume, :type, Integer
  validate :volume, :min, 1

  # rubocop:disable Lint/MissingSuper
  def initialize(volume)
    @type = :cargo
    @volume = volume
    @reserved_volume = 0
    validate! unless valid?
  end
  # rubocop:enable Lint/MissingSuper

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
end
