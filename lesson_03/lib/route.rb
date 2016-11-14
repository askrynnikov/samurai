require_relative('station')

class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
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

  def start_station
    stations.first
  end

  def end_station
    stations.last
  end

  def has_station?(station)
    @stations.include?(station)
  end

  def to_s
    @stations
  end
end
