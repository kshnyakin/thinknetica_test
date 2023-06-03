module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@instance_counter, 0)
  end

  module ClassMethods
    def instances
      self.class_variable_get(:@@instance_counter)
    end
  end

  module InstanceMethods
    def initialize
      register_instance
    end

    private
    def register_instance
      current_counter = self.class.class_variable_get(:@@instance_counter)
      self.class.class_variable_set(:@@instance_counter, current_counter += 1)
    end
  end

end