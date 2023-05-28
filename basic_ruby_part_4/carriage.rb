class Carriage
  @@object_ids = []
  def initialize
    @@object_ids << self.object_id
  end

  def self.list
    @@object_ids.map{|object_id| ObjectSpace._id2ref(object_id) }
  end
end

class CargoCarriage < Carriage
end

class PassengerCarriage < Carriage
end