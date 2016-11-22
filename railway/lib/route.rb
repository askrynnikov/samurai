require_relative 'instance_counter'
require_relative 'station'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  @@routrs = []

  attr_reader :stations

  def self.routrs
    @@routrs
  end

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    @@routrs << self
    @circular = start_station == end_station
    validate!
    register_instance
  end

  def [](index)
    @stations[index]
  end

  def next_waypoint(waypoint)
    (waypoint + 1) if waypoint < last_waypoint
  end

  def next_station(waypoint)
    stations[next_waypoint(waypoint)]
  end

  def previous_waypoint(waypoint)
    (waypoint - 1) if waypoint > last_waypoint
  end

  def previous_station(waypoint)
    stations[previous_waypoint(waypoint)]
  end

  def add_intermediate_station(station, next_station = nil)
    if next_station
      @stations.insert(@stations.index(next_station), station)
    else
      @stations.insert(-2, station)
    end
    self
  end

  def delete_intermediate_station(station)
    @stations.delete(station) if self.has_station?(station)
  end

  def puts_stations
    stations.each { |station| puts station }
  end

  def first_waypoint
    0
  end

  def last_waypoint
    stations.size - 1
  end

  def start_station
    stations[first_waypoint]
  end

  def end_station
    stations[last_waypoint]
  end

  def has_station?(station)
    @stations.include?(station)
  end

  def circular?
    @circular
  end

  def to_s
    @stations
  end

  private

  def validate!
    unless stations.all? { |item| item.is_a?(Station) }
      raise "Route shall contain only stations"
    end
    true
  end

end
