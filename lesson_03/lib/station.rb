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

  def send_train(train, initiator = self)
    if self.has_train?(train)
      @trains.delete(train)
      train.go_to_next_station(self) unless initiator === Train
    end
    self
  end

  def numbers_trains
    @trains.map(&:number)
  end

  def print_numbers_trains
    puts "На станции #{name} находятся поезда:"
    puts self.numbers_trains
  end

  def amount_trains_by_type
    @trains.reduce(Hash.new(0)) { |sum, train| sum[train.type] += 1; sum }
  end

  def print_amount_trains_by_type
    puts "Колличество поездов по типам находящихся на станции #{name}"
    puts amount_trains_by_type.to_a
  end

  def has_train?(train)
    trains.include?(train)
  end
end
