require_relative '../train'

class Train
  class Cargo < Train
    def initialize(number)
      super(number, :cargo)
    end

    def attach_carriages(*units)
      if units.first.is_a?(Integer)
        units.first.times { attach_carriage(Carriage::Cargo.new) }
      else
        units.each { |unit| attach_carriage(unit) }
      end
      self
    end

    def attach_carriage(carriage)
      super if carriage.instance_of?(Carriage::Cargo)
      self
    end
  end
end
