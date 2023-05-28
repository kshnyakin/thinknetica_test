class Station
  attr_reader :name, :trains
  @@object_ids = []
  def initialize(name)
    @name = name
    @trains = []
    @@object_ids << self.object_id
  end
  
  def self.list
    @@object_ids.map{|object_id| ObjectSpace._id2ref(object_id) }
  end

  def receive_train(train)
    trains << train
  end

  def dispatch_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select{|train| train.type == type}.size
  end
end