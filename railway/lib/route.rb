require_relative 'instance_counter'
require_relative 'station'
require_relative 'validation'

# routes of trains
class Route
  include InstanceCounter
  include Validation

  # errors train
  class NoStation < StandardError
    def initialize(msg = 'Route shall contain only stations')
      super
    end
  end

  attr_reader :stations

  class << self
    alias routs all
  end

  def initialize(first, last)
    raise NoStation unless first.is_a?(Station) && last.is_a?(Station)
    @stations = [first, last]
    @circular = first == last
    register_instance
  end

  def [](index)
    @stations[index]
  end

  def next_waypoint(waypoint)
    waypoint + (waypoint < last_waypoint ? 1 : 0)
  end

  def next_station(waypoint)
    stations[next_waypoint(waypoint)]
  end

  def previous_waypoint(waypoint)
    waypoint - (waypoint > last_waypoint ? 1 : 0)
  end

  def previous_station(waypoint)
    stations[previous_waypoint(waypoint)]
  end

  def add_station(station, next_station = nil)
    raise NoStation unless station.is_a?(Station)
    if next_station
      @stations.insert(@stations.index(next_station), station)
    else
      @stations.insert(-2, station)
    end
    self
  end

  def delete_intermediate_station(station)
    @stations.delete(station) if station?(station)
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

  def first_station
    stations[first_waypoint]
  end

  def last_station
    stations[last_waypoint]
  end

  def station?(station)
    @stations.include?(station)
  end

  def circular?
    @circular
  end

  def to_s
    @stations
  end
end
