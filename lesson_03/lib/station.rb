require_relative 'train'

class Station
  @@stations = []

  attr_reader :name, :trains

  def self.stations
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def take_train(train)
    @trains << train unless self.has_train?(train)
    self
  end

  def send_train(train)
    train.go_to_next_station if self.has_train?(train)
    self
  end

  def departed_train(train)
    @trains.delete(train) unless train.at_station == self
    self
  end

  def numbers_trains
    @trains.map(&:number)
  end

  def amount_trains_by_type
    @trains.reduce(Hash.new(0)) { |sum, train| sum[train.type] += 1; sum }
  end

  def has_train?(train)
    trains.include?(train)
  end
end
