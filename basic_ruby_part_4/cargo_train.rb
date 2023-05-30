class CargoTrain < Train

  attr_reader :type
  def initialize(number)
    super(number)
    @type = :cargo
  end

  def add_carriage(carriage)
    if carriage.class == CargoCarriage
      super(carriage)
    end
  end
end