# frozen_string_literal: true

# Accessors module extends Class methods with
# attr_accesor_with_history / strong_attr_accesor methods
module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Class methods
  module ClassMethods
    def attr_accesor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        defining_setter_method(name, var_name)
      end
    end

    def strong_attr_accesor(name, class_name)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        raise "Error, value (#{value}) class is not #{class_name}" if value.class != class_name

        instance_variable_set(var_name, value)
      end
    end

    private

    def defining_setter_method(name, var_name)
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history_var_name = "@#{name}_history".to_sym
        history_var_value = instance_variable_get(history_var_name)
        add_or_init_history_value(history_var_value, history_var_name, value, name)
      end
    end
  end

  # Instance methods
  module InstanceMethods
    def add_or_init_history_value(history_var_value, history_var_name, value, name)
      if history_var_value
        instance_variable_set(history_var_name, history_var_value << value)
      else
        instance_variable_set(history_var_name, [value])
        self.class.send(:attr_reader, "#{name}_history".to_sym)
      end
    end
  end
end
