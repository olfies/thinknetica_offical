# frozen_string_literal: false

require_relative 'cargo_carriage.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'menu.rb'
require_relative 'train.rb'

class Main
  def select_actions_menu
    puts <<-HEREDOC
          Select action from menu:
            (1)New station
            (2)New train
            (3)New wagon
            (4)Delete carriage
            (5)Add train to statios
            (6)All stations
            (7)List trains to stations
            (8)Exit
    HEREDOC
    run_action(gets.chomp)
  end

  def run_action(action)
    case action.to_i
    when 1 then new_station
    when 2 then new_train
    when 3 then new_wagon
    when 4 then delete_carriage
    when 5 then add_train_to_station
    when 6 then all_stations
    when 7 then list_trains_to_station
    when 8 then
      puts 'Good bye!'
      :exit
    else
      select_actions_menu
    end
  end

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def run_main
    run_action(select_actions_menu) while select_actions_menu != :exit
  end

  private

  def new_station
    puts 'Пожалуйста, укажите название станции (возможные буквы и цифры):'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "Станиця '#{station_name}' создана. Все станции: #{@stations.join(',')} "
  rescue StandardError => e
    puts e.message
    retry
  end

  def new_train
    puts 'Укажите тип поезда (cargo или passenger)'
    type = gets.chomp.to_sym
    puts 'Укажите номер поезда'
    num = gets.chomp
    if num.to_i
      puts "Создан поезд типа #{type} номер #{num}"
    else
      puts 'Такого типа поезда нет'
    end
  end

  def all_stations
    @stations.each_with_index { |station, n| puts " #{n} #{station.name}" }
  end

  def add_train_to_station
    puts 'Выберите номер станции к которой хотите добавить поезд'
    num_station = gets.chomp.to_i
    puts 'Укажите номер поезда'
    num_train = gets.chomp.to_i
    puts "На станцию #{num_station} Прибыл поезд #{num_train}"
  end

  def list_trains_to_station
    puts "Напишите имя станции"
    name = gets.chomp
    puts " На станции #{name} находятся поезда: "
    trains = lambda do |train|
      puts train
      puts "№: #{train.num}, тип: #{train.type}, вагонов: #{train.carriages.length} "
    end

  def delete_carriage
    puts 'Укажите номер поезда'
    num = gets.chomp
    @trains.delete(num)
    puts "Поезд под номером #{num} удален "
  end

  def new_wagon
    puts 'Выберите тип вагона: cargo(1) passenger (2): '
    action = gets.to_i
    case action
    when 1
      CargoCarriage.new
      puts "Вагон типа Cargo создан"
    when 2
      PassengerCarriage.new
      puts "Вагон типа Passenger создан"
    else
    puts "Попробуете еще раз"
    end
  end
end

end

main = Main.new
main.run_main
