require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Train
  USIAL_AMOUNT_CARRIADES = 12

  @@trains = []

  attr_reader :number, :type, :amount_carriages, :speed, :carriages,
              :previous_station, :at_station, :next_station, :waypoint

  def self.trains
    @@trains
  end

  def initialize(number, type, amount_carriages = USIAL_AMOUNT_CARRIADES)
    @number, @type = number, type
    @speed = 0
    @carriages = []
    @route = nil
    @waypoint = nil
    @previous_station, @at_station, @next_station = nil
    @@trains << self
    attach_carriages(amount_carriages)
  end

  def attach_carriages(*units)
    if units.first.is_a?(Integer)
      units.first.times { attach_carriage(Carriage.new) }
    else
      units.each { |unit| attach_carriage(unit) }
    end
    self
  end

  def attach_carriage(carriage)
    @carriages << carriage if speed == 0
    self
  end

  def detach_carriage(carriage)
    @carriages.delete(carriage) if speed == 0
    self
  end

  def amount_carriages
    @carriages.size
  end

  def accelerates(up_speed = 10)
    self.speed += up_speed
  end

  def breaks(down_speed = 0)
    return self.speed = 0 if down_speed == 0
    down_speed = -down_speed if down_speed < 0
    if down_speed>=speed
      self.speed = 0
    else
      self.speed -= down_speed
    end
  end

  def stop
    self.breaks
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

  # вынесено в protected поскольку скорость изменяется не произвольно
  # а в прецессе разгона и торможения
  def speed=(speed)
    @speed = speed
  end

  # вынесено в protected поскольку колличество вагонов изменяется не произвольно
  # а в процессе сцепки-разцепки поезда и вагона
  def amount_carriages=(amount_carriages)
    @amount_carriages = amount_carriages
  end

end


class PassengerTrain < Train
  USIAL_AMOUNT_CARRIADES = 12

  def initialize(number, amount_carriages = USIAL_AMOUNT_CARRIADES)
    super(number, :passenger, amount_carriages)
  end

  def attach_carriages(*units)
    if units.first.is_a?(Integer)
      units.first.times { attach_carriage(PassengerCarriage.new) }
    else
      units.each { |unit| attach_carriage(unit) }
    end
    self
  end

  def attach_carriage(carriage)
    @carriages << carriage if speed == 0 && carriage.instance_of?(PassengerCarriage)
    self
  end
end

class CargoTrain < Train
  USIAL_AMOUNT_CARRIADES = 50

  def initialize(number, amount_carriages = USIAL_AMOUNT_CARRIADES)
    super(number, :cargo, amount_carriages)
  end

  def attach_carriages(*units)
    if units.first.class.is_a?(Integer)
      units.first.times { attach_carriage(CargoCarriage.new) }
    else
      units.each { |unit| attach_carriage(unit) }
    end
    self
  end

  def attach_carriage(carriage)
    self.carriages << carriage if speed == 0 && carriage.instance_of?(CargoCarriage)
    self
  end
end

