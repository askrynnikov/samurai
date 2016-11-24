require_relative '../train'

class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end

  def attach_carriages(*units)
    if units.first.is_a?(Integer)
      units.first.times { attach_carriage(CargoCarriage.new) }
    else
      units.each { |unit| attach_carriage(unit) }
    end
    self
  end

  def attach_carriage(carriage)
    super if carriage.instance_of?(CargoCarriage)
    self
  end
end
