module CLI
  extend self

  def run
    puts 'Управление железной дорогой'
    puts 'Интерфейс командной строки'
    loop do
      puts "\nВведите команду:\n" +
             "[1] - Create train\n" +
             "[2] - Puts trains\n" +
             "[0] - Exit"
      action = gets.chomp
      case action
      when '1'
        create_train
      when '2'
        show_trains
      when '0'
        break
      else
        puts 'Недопустимая команда'
      end
    end
  end

  private

  def create_train
    puts "\nВведите тип поезда:\n" +
           "[1] - пассажирский\n" +
           "[2] - грузовой"
    type = gets.chomp
    unless ('1'..'2').include?(type)
      raise ArgumentError, "Выбран недопустимый тип поезда!"
    end

    puts "\nВведите номер поезда:"
    number = gets.chomp

    train = case type
            when '1'
              PassengerTrain.new(number)
            when '2'
              CargoTrain.new(number)
            end
    puts "Создан поезд №#{train}"

  rescue => e
    puts e.message
    retry
  end

  def show_trains
    puts "\nОбщий список поездов:"
    puts Train.trains
  end
end