# frozen_string_literal: false

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
            (3)Add carriage
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
    when 3 then add_carriage
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
    puts 'Укажите имя станции:'
    name = gets.chomp
    puts "Создана станция #{name}"
  end

  def add_carriage
    puts 'Укажите объем вагона'
    capacity = gets.chomp.to_i
    puts 'Укажите количество мест в вагоне'
    capac = gets.chomp.to_i
    puts "Создан вагон обьемом #{capacity} и с #{capac} местами"
  end

  def add_train_to_station
    puts 'Выберите номер станции к которой хотите добавить поезд'
    puts all_stations
    num_station = gets.chomp.to_i
    puts 'Укажите номер поезда'
    num_tr = gets.chomp.to_i
    puts "На станцию #{num_station} Прибыл поезд #{trains[num_tr]}"
  end

  def all_stations
    @stations.each_with_index { |station, n| puts " #{n} #{station.name}" }
  end

  def list_trains_to_station
    puts 'Выберите номер станции'
    puts all_stations
    ation = gets.chomp.to_i
    selected_station = @stations[ation]
    puts " На станции #{station.name} находятся поезда: "
    trains = train
    puts train
    puts "№: #{train.num}, тип: #{train.type}, вагонов: #{train.carriages.length} "
    station.train_in(trains)
  end

  def delete_carriage
    puts 'Укажите номер поезда'
    num = gets.chomp
    @trains.carriage.delete(num)
  end

  def new_train
    puts 'Укажите тип поезда (cargo или passenger)'
    type = gets.chomp.to_sym
    puts 'Укажите номер поезда'
    num = gets.chomp
    create_train!(type, num)
  end
end

main = Main.new
main.run_main
