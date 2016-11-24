require_relative '../carriage'

class Carriage
  class Cargo < Carriage
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

    def print
      puts "#{number} " +
             "#{type} " +
             "free:#{free_volume_cargo} " +
             "busy:#{busy_volume_cargo}"
    end
  end
end