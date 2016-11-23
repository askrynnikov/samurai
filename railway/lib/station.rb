require_relative 'instance_counter'
require_relative 'train'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /[[:alpha:]]+/

  @@stations = []

  attr_reader :name, :trains

  def self.all
    @@stations
  end

  def self.stations
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
    register_instance
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

  private

  def validate!
    raise 'Station must have a name' if name !~ NAME_FORMAT
    true
  end

end
