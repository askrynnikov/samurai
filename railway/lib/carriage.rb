require_relative 'instance_counter'
require_relative 'manufacturer'

class Carriage
  include InstanceCounter
  include Manufacturer

  attr_reader :type

  def initialize(type = nil)
    register_instance
    @type = type
  end
end
