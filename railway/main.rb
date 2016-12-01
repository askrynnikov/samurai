# frozen_string_literal: true
require_relative 'lib/station'
require_relative 'lib/route'
require_relative 'lib/train/passenger'
require_relative 'lib/train/cargo'
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

moscow = Station.new('Москва')
tver = Station.new('Тверь')
bologoe = Station.new('Бологое')
piter = Station.new('Санкт-Петербург')
nizhny = Station.new('Нижний Новгород')
kazan = Station.new('Казань')
samara = Station.new('Самара')

moscow_piter = Route.new(moscow, piter)
moscow_piter.add_station(tver)
moscow_piter.add_station(bologoe)

moscow_samara = Route.new(moscow, samara)
moscow_samara.add_station(nizhny)
moscow_samara.add_station(kazan)

cp1 = Car::Passenger.new(52)
cp2 = Car::Passenger.new(52)
m_p_001_ps = Train::Passenger
             .new('001-ps')
             .load_route(moscow_piter)
             .attach_cars(cp1, cp2)
             .each { |car| rand(car.seats).times { car.take_seat } }
             .go_next.go_next

cc1 = Car::Cargo.new(42_000)
cc2 = Car::Cargo.new(42_000)
m_s_050_cr = Train::Cargo
             .new('001-cr')
             .load_route(moscow_samara)
             .attach_cars(cc1, cc2)
             .each { |car| car.take_cargo(rand(car.volume)) }
             .go_next

m_p_001_ps.go_next
m_s_050_cr.go_next

# puts Train.trains
# puts Station.stations
# Train.trains.each(&:print)
# Station.stations.each(&:print)
# CLI.run

moscow.test1 = 1
# moscow.test1 = 2
moscow.test1 = 3
p moscow.test1
puts
p moscow.test1_history

moscow.test2 = 'aaaa'
moscow.test2 = '2'
