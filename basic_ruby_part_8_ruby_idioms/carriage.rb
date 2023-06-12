# frozen_string_literal: true

require_relative 'manufacturer'

# Class for creating carriages
class Carriage
  include Manufacturer
  attr_reader :type
end
