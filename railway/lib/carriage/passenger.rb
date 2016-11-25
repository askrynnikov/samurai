require_relative '../carriage'

class Carriage
  class Passenger < Carriage
    attr_reader :seats, :busy_seats

    def initialize(seats = 0)
      super(:passenger)
      @seats = seats
      @busy_seats = 0
    end

    def take_seat
      @busy_seats += 1 if @busy_seats < @seats
      self
    end

    def free_seats
      @seats - @busy_seats
    end

    def to_s
      "#{number} #{type} free:#{free_seats} busy:#{busy_seats}"
    end
  end
end
