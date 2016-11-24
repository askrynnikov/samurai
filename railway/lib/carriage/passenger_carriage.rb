require_relative '../carriage'

class PassengerCarriage < Carriage
  attr_reader :number_seats, :occupied_number_seats

  def initialize(number_seats = 0)
    super(:passenger)
    @number_seats = number_seats
    @occupied_number_seats = 0
  end

  def take_seat
    @occupied_number_seats += 1 if occupied_number_seats < number_seats
    self
  end

  def empty_number_seats
    number_seats - occupied_number_seats
  end

  def print
    puts "#{number} " +
           "#{type} " +
           "free:#{empty_number_seats} " +
           "busy:#{occupied_number_seats}"
  end
end
