require_relative '../car'

class Car
  # Cargo car
  class Cargo < Car
    attr_reader :volume, :busy_volume

    def initialize(volume)
      super(:cargo)
      @volume = volume
      @busy_volume = 0
    end

    def take_cargo(cargo)
      @busy_volume += cargo if cargo < free_volume
      self
    end

    def free_volume
      @volume - @busy_volume
    end

    def to_s
      "#{number} #{type} free:#{free_volume} busy:#{busy_volume}"
    end
  end
end
