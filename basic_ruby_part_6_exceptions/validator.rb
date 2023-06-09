module Validator
  private

  def valid?
    validate!
    true
  rescue
    false
  end

end