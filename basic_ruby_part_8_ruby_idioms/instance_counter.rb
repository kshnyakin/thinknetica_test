# frozen_string_literal: true

# Module for counting instances
# rubocop:disable Style/ClassVars
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@instance_counter_hash, Hash.new(0))
  end

  # Class methods
  module ClassMethods
    def instances
      class_variable_get(:@@instance_counter_hash)[to_s]
    end
  end

  # Instance methods
  module InstanceMethods
    private

    def register_instance
      src = self.class
      current_counter = self.class.class_variable_get(:@@instance_counter_hash)
      current_counter[src.to_s] += 1
      self.class.class_variable_set(:@@instance_counter_hash, current_counter)
    end
  end
end
# rubocop:enable Style/ClassVars
