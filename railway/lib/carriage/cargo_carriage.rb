require_relative '../carriage'

class CargoCarriage < Carriage
  def initialize
    super(:cargo)
  end
end
