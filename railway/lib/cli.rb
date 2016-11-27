# Command-line interface
module CLI
  TYPE_NAMES = { '1' => Train::Passenger, '2' => Train::Cargo }.freeze

  GREETING = <<-GREETING
Railway Management
Command-line interface
  GREETING
             .freeze

  MENU_COMMAND = <<-MENU

Enter the command:
[1] - Create train
[2] - Puts trains
[0] - Exit
  MENU
                 .freeze

  MENU_TYPE_TRAIN = <<-MENU

Enter the type of train:
[1] - passenger
[2] - cargo
  MENU
                    .freeze

  def run
    puts GREETING
    # act = {'0' => :break, '1' =>:create_train, '2' => :show_trains}
    loop do
      puts MENU_COMMAND
      case gets.chomp
      when '1' then create_train
      when '2' then show_trains
      when '0' then break
      else puts 'Invalid command'
      end
    end
  end

  private

  def create_train
    puts MENU_TYPE_TRAIN
    type = gets.chomp
    raise ArgumentError, 'Invalid type of train!' unless TYPE_NAMES[type]

    puts "\nEnter the train number:"
    number = gets.chomp
    train = TYPE_NAMES[type].new(number)
    puts "Created train №#{train}"

  rescue => e
    puts e.message
    retry
  end

  def show_trains
    puts "\nThe total list of trains:"
    puts Train.trains
  end

  module_function :run, :create_train, :show_trains
end
