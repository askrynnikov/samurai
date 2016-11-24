require_relative '../train'

class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
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
    super if carriage.instance_of?(PassengerCarriage)
    self
  end
end
