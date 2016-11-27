# frozen_string_literal: true
require_relative '../train'

class Train
  # Passenger Train
  class Passenger < Train
    def initialize(number)
      super(number, :passenger)
      Train.send :add_instance, self
    end

    def attach_cars(*units)
      if units.first.is_a?(Integer)
        units.first.times { attach_car(Car::Passenger.new) }
      else
        units.each { |unit| attach_car(unit) }
      end
      self
    end

    def attach_car(car)
      super if car.instance_of?(Car::Passenger)
      self
    end
  end
end
