# frozen_string_literal: true
require_relative 'route'
require_relative 'station'
require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validation'
require_relative 'car/passenger'
require_relative 'car/cargo'

# railway train
class Train
  include InstanceCounter
  include Manufacturer
  include Validation

  # errors train
  class NumberError < StandardError
    def initialize(msg = 'Train number has invalid format')
      super
    end
  end

  NUMBER_FORMAT = /\A[[:alnum:]]{3}-*[[:alnum:]]{2}\z/

  attr_reader :number, :type, :amount_cars, :speed, :cars,
              :previous_station, :at_station, :next_station, :waypoint
  validate :number, :format, NUMBER_FORMAT
  @test_var_class1 = 'aaa'

  class << self
    alias trains all
  end

  def self.find(number)
    trains.find { |train| train.number == number }
  end

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @cars = []
    @route, @waypoint, @previous_station, @at_station, @next_station = nil
    validate!
    register_instance
  end

  def print
    puts "\n№#{number} #{type} cars:#{amount_cars}"
    puts 'Сarriages:'
    each { |car| puts car }
  end

  def each(&block)
    cars.each(&block)
    self
  end

  def to_s
    number
  end

  def attach_cars(*units)
    if units.first.is_a?(Integer)
      units.first.times { attach_car(Car.new) }
    else
      units.each { |unit| attach_car(unit) }
    end
    self
  end

  def attach_car(car)
    if speed.zero? && car.is_a?(Car)
      @cars << car
      car.number = cars.map { |car_in_train| car_in_train.number || 0 }.max + 1
    end
    self
  end

  def detach_car(car)
    @cars.delete(car) if speed.zero?
    self
  end

  def amount_cars
    @cars.size
  end

  def accelerates(up_speed = 10)
    self.speed += up_speed
  end

  def breaks(down_speed = 0)
    return self.speed = 0 if down_speed.zero?
    self.speed -= down_speed
    self.speed = [speed, 0].max
  end

  def stop
    breaks
  end

  def load_route(route)
    @route = route
    @waypoint = route.first_waypoint
    @previous_station = route.first_station
    @at_station = route.first_station
    @at_station.take_train(self)
    @next_station = route.next_station(waypoint)
    self
  end

  def go_next
    @previous_station = @at_station
    @at_station = @next_station
    @previous_station.departed_train(self)
    @waypoint = @route.next_waypoint(@waypoint)
    @next_station = @route.next_station(@waypoint)
    @at_station.take_train(self)
    self
  end

  protected

  # protected so as the rate of change in the process
  # of acceleration and deceleration
  # protected as the number of cars changed during
  # the coupling-uncoupling train and car
  attr_writer :amount_cars, :speed
end
