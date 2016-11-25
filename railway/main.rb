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

cp1 = Carriage::Passenger.new(52)
cp2 = Carriage::Passenger.new(52)
m_p_001_ps = Train::Passenger.new('001-ps')
  .load_route(moscow_piter)
  .attach_carriages(cp1, cp2)
  .each {|carriage| rand(carriage.seats).times { carriage.take_seat }}
  .go_next.go_next

cc1 = Carriage::Cargo.new(42000)
cc2 = Carriage::Cargo.new(42000)
m_s_050_cr = Train::Cargo.new('001-cr')
  .load_route(moscow_samara)
  .attach_carriages(cc1, cc2)
  .each { |carriage| carriage.take_cargo(rand(carriage.volume)) }
  .go_next

# m_p_001_ps.print_carriages
# m_s_050_cr.print_carriages

Station.all.each(&:print)
CLI.run
