require_relative 'lib/station'
require_relative 'lib/route'
require_relative 'lib/train'

def print_numbers_trains(station)
  puts "На станции #{name} находятся поезда:"
  puts station.numbers_trains
end

def print_amount_trains_by_type(station)
  puts "Колличество поездов по типам находящихся на станции #{name}"
  puts amount_trains_by_type.to_a
end

mosсow = Station.new('Москва')
piter = Station.new('Санкт-Петербург')
route_mosсow_piter = Route.new(mosсow, piter)
bologoe = Station.new('Бологое')
chudovo = Station.new('Чудово')
tver = Station.new('Тверь')
route_mosсow_piter.add_intermediate_station(bologoe)
route_mosсow_piter.add_intermediate_station(chudovo)
route_mosсow_piter.add_intermediate_station(tver, bologoe)

train_209 = Train.new('209', :passenger, 12)
train_209.load_route(route_mosсow_piter)

train_209.go_to_next_station
print tver.numbers_trains
train_209.go_to_next_station
print bologoe.numbers_trains
bologoe.send_train(train_209)
print chudovo.numbers_trains
