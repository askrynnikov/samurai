require_relative 'route'
require_relative 'station'

class Train
  TYPES = [:cargo, :passenger]

  @@trains = []

  attr_reader :number, :type, :amount_carriages, :speed,
              :previous_station, :at_station, :next_station, :waypoint

  def self.trains
    @@trains
  end

  def initialize(number, type, amount_carriages)
    @number = number
    @type = type
    @amount_carriages = amount_carriages
    @speed = 0
    @route = nil
    @waypoint = nil
    @previous_station = nil
    @at_station = nil
    @next_station = nil
    @@trains << self
  end

  def accelerates(up_speed = 10)
    self.speed += up_speed
  end

  def breaks(down_speed = nil)
    if down_speed.nil? || down_speed>=speed
      self.speed = 0
    else
      self.speed -= down_speed
    end
  end

  def stop
    self.breaks
  end

  def attach_carriage
    self.amount_carriages += 1 if speed == 0
  end

  def detach_carriage
    self.amount_carriages -= 1 if speed == 0 && amount_carriages > 0
  end

  def load_route(route)
    @route = route
    @waypoint = route.first_waypoint
    @previous_station = route.start_station
    @at_station = route.start_station
    @at_station.take_train(self)
    @next_station = route.next_station(waypoint)
    self
  end

  def go_to_next_station
    @at_station.departed_train(self)
    @previous_station = @at_station
    @at_station = @next_station
    @waypoint = @route.next_waypoint(@waypoint)
    @next_station = @route.next_station(@waypoint)
    @at_station.take_train(self)
    self
  end

  protected

  def speed=(speed)
    @speed = speed
  end

  def amount_carriages=(amount_carriages)
    @amount_carriages = amount_carriages
  end
end
