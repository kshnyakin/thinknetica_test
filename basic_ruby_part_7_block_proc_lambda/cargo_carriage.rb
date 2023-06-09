require_relative 'validator'

class CargoCarriage < Carriage
  include Validator

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @reserved_volume = 0
    validate! unless valid?
  end

  def reserve_volume(size)
    raise "Error: can not reserve #{size}, "\
          "avaliable to reserve volume = #{free_volume}" if size > free_volume
    @reserved_volume += size
  end

  def reserved_volume
    @reserved_volume
  end

  def free_volume
    @volume - @reserved_volume
  end

  private
  
  def validate!
    errors = []
    errors << 'Cargo volume be an integer number' if @volume.class != Integer
    errors << 'Cargo volume must be greater than null' if @volume.class == Integer && @volume < 1
    raise errors.join(', ') unless errors.empty?
  end
end
