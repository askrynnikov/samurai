require_relative '../carriage'

class CargoCarriage < Carriage
  attr_reader :volume_cargo, :busy_volume_cargo

  def initialize(volume_cargo)
    super(:cargo)
    @volume_cargo = volume_cargo
    @busy_volume_cargo = 0
  end

  def take_cargo(cargo)
    @busy_volume_cargo += cargo if cargo < free_volume_cargo
    self
  end

  def free_volume_cargo
    volume_cargo - busy_volume_cargo
  end
end
