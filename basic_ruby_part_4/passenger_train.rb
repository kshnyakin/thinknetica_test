class PassengerTrain < Train

  attr_reader :type
  def initialize(number)
    super(number)
    @type = :passenger
  end

  def add_carriage(carriage)
    if carriage.class == PassengerCarriage
      super(carriage)
    end
  end
end 