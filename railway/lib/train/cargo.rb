require_relative '../train'

class Train
  # Cargo Train
  class Cargo < Train
    def initialize(number)
      super(number, :cargo)
      Train.send :add_instance, self
    end

    def attach_cars(*units)
      if units.first.is_a?(Integer)
        units.first.times { attach_car(Car::Cargo.new) }
      else
        units.each { |unit| attach_car(unit) }
      end
      self
    end

    def attach_car(car)
      super if car.instance_of?(Car::Cargo)
      self
    end
  end
end
