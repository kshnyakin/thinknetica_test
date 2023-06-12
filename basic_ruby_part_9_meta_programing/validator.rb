# frozen_string_literal: true

# Module for adding common valid? method
module Validator
  private

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
