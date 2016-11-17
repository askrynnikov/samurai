class PassengerTrain < Train
  USIAL_AMOUNT_CARRIADES = 12

  def initialize(number, amount_carriages = USIAL_AMOUNT_CARRIADES)
    super(number, :passenger, amount_carriages)
  end

  def attach_carriages(*units)
    if units.first.is_a?(Integer)
      units.first.times { attach_carriage(PassengerCarriage.new) }
    else
      units.each { |unit| attach_carriage(unit) }
    end
    self
  end

  def attach_carriage(carriage)
    @carriages << carriage if speed == 0 && carriage.instance_of?(PassengerCarriage)
    self
  end
end
