# frozen_string_literal: true

# Validation module extends Instnace for methods validate! / valid?
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Class methods
  module ClassMethods
    # rubocop:disable Metrics/MethodLength
    def validate(attr_name, *params)
      case params[0]
      when :presence
        create_presence_validation(attr_name)
      when :format
        create_format_validation(attr_name, params[1])
      when :type
        create_type_validation(attr_name, params[1])
      when :length
        create_length_validation(attr_name, params[1])
      when :min
        create_min_value_validation(attr_name, params[1])
      end
    end
    # rubocop:enable Metrics/MethodLength

    private

    def create_presence_validation(attr_name)
      define_method("#{attr_name}_presence_validation") do
        instance_value = extract_instance_variable(attr_name)
        raise_text = "Attribute #{attr_name} must be not nil or emty_string"
        raise raise_text if instance_value.nil? || instance_value == ''
      end
    end

    def create_format_validation(attr_name, regexp)
      define_method("#{attr_name}_format_validation") do
        instance_value = extract_instance_variable(attr_name)
        raise_text = "Attribute #{attr_name} must satisfy regexp validation = #{regexp}"
        raise raise_text if (instance_value =~ regexp).nil?
      end
    end

    def create_type_validation(attr_name, class_name)
      define_method("#{attr_name}_type_validation") do
        instance_value = extract_instance_variable(attr_name)
        raise_text = "Attribute #{attr_name} class not equal to #{class_name}"
        raise raise_text if instance_value.class != class_name
      end
    end

    def create_length_validation(attr_name, length)
      define_method("#{attr_name}_length_validation") do
        instance_value = extract_instance_variable(attr_name)
        raise_text = "Attribute #{attr_name} length must be greater or equal #{length}"
        raise raise_text if instance_value.to_s.length < length
      end
    end

    def create_min_value_validation(attr_name, min_value)
      define_method("#{attr_name}_min_value_validation") do
        instance_value = extract_instance_variable(attr_name)
        raise_text = "Attribute #{attr_name} value must be greater #{min_value}"
        raise raise_text if instance_value.to_i < min_value
      end
    end
  end

  # Instance methods
  module InstanceMethods
    def validate!
      errors = []
      validations_methods = self.class.instance_methods.select do |method|
        method.to_s.include? 'validation'
      end
      validations_methods.each do |method|
        send(method)
      rescue StandardError => e
        errors << e.message
      end
      raise errors.join(', ') unless errors.empty?
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def extract_instance_variable(attr_name)
      instance_variable_get("@#{attr_name}".to_sym)
    end
  end
end
