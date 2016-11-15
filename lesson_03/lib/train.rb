require_relative 'route'
require_relative 'station'

class Train
  TYPES = [:cargo, :passenger]

  @@trains = []

  attr_reader :number, :type, :amount_carriages, :speed,
              :previous_station, :at_station, :next_station

  def self.trains
    @@trains
  end

  def initialize(number, type, amount_carriages)
    @number = number
    @type = type
    @amount_carriages = amount_carriages
    @speed = 0
    @route = nil
    @index_station = nil
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
    @index_station = 0
    @previous_station = @route.start_station
    @at_station = @route.start_station
    @at_station.take_train(self)
    @next_station = @route.stations[1]
    self
  end

  def go_to_next_station(initiator = self)
    # OPTIMIZE improve the code
    @previous_station = @route.stations[index_station]
    @previous_station.send_train(self, self) unless initiator.class == Station
    self.index_station += 1
    if index_station >= @route.stations.size
      self.index_station = 0
      if @route.first != @route.last
        @route.reverse!
      end
    end

    @at_station = @route.stations[index_station]
    @at_station.take_train(self)

    if index_station < @route.stations.size
      @next_station = @route.stations[index_station + 1]
    else
      if @route.first != @route.last
        @next_station = @route[-2]
      else
        @next_station = @route[0]
      end
    end
    self
  end

  protected

  def speed=(speed)
    @speed = speed
  end

  def amount_carriages=(amount_carriages)
    @amount_carriages = amount_carriages
  end

  def index_station=(index_station)
    @index_station = index_station
  end

  def index_station
    @index_station
  end
end
