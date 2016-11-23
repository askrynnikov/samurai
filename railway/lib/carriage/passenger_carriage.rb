require_relative '../carriage'

class PassengerCarriage < Carriage
  attr_reader :number_seats, :number_occupied_seats

  def initialize(number_seats)
    super(:passenger)
    @number_seats = number_seats
    @number_occupied_seats = 0
  end

  def take_seat
    number_occupied_seats += 1 if number_occupied_seats < number_seats
  end

  def number_empty_seats
    number_seats - number_occupied_seats
  end
end
