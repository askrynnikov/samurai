require_relative 'lib/station'
require_relative 'lib/route'
require_relative 'lib/train/passenger_train'
require_relative 'lib/train/cargo_train'
require_relative 'lib/train'
require_relative 'lib/cli'

def print_numbers_trains(station)
  puts "На станции #{name} находятся поезда:"
  puts station.numbers_trains
end

def print_amount_trains_by_type(station)
  puts "Колличество поездов по типам находящихся на станции #{name}"
  puts station.amount_trains_by_type.to_a
end

# train = CargoTrain.new('123-12')
# t = train.valid?
# t = train.valid?

CLI.run
