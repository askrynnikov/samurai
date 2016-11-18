class Carriage
  attr_reader :type

  def initialize(type = nil)
    @type = type
  end

  protected
end
