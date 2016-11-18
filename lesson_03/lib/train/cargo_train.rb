class CargoTrain < Train
  USIAL_AMOUNT_CARRIADES = 50

  def initialize(number, amount_carriages = USIAL_AMOUNT_CARRIADES)
    super(number, :cargo, amount_carriages)
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
    self.carriages << carriage if speed == 0 && carriage.instance_of?(CargoCarriage)
    self
  end
end
