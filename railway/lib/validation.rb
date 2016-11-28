# check the contents of the object
module Validation
  def valid?
    validate!
    true
  rescue
    false
  end
end
