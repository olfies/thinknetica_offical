# frozen_string_literal: false

require_relative 'validation.rb'
require_relative 'cargo_carriage.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'menu.rb'
require_relative 'train.rb'
require_relative 'accessors.rb'
require 'pry'

class Main
  def select_actions_menu
    puts <<-HEREDOC
          Select action from menu:
            (1)New station
            (2)Create train selection
            (3)Create carriage
            (4)Delete carriage
            (5)Add train to statios
            (6)All stations
            (7)List trains to stations
            (8)Create route
            (9)Add stations to route
            (10)Remove stations from route
            (11)Assing route to train
            (12)Move train
            (13)Exit
    HEREDOC
    run_action(gets.chomp)
  end

  def run_action(action)
    case action.to_i
    when 1 then new_station
    when 2 then create_train_selection
    when 3 then create_carriage
    when 4 then delete_carriage
    when 5 then add_train_to_station
    when 6 then all_stations
    when 7 then list_trains_to_station
    when 8 then select_route_stations
    when 9 then add_stations_to_route
    when 10 then remove_stations_from_route
    when 11 then assign_route_to_train
    when 12 then move_train
    when 13
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

  attr_reader :type

  def new_station
    puts 'Пожалуйста, укажите название станции (возможные буквы и цифры):'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "Станиця '#{station_name}' создана. Все станции: #{@stations.join(',')} "
  rescue StandardError => e
    puts e.message
    retry
  end
end

def move_train
  if @trains.empty?
    puts 'There are no trains to move. Please, create one.'
  else
    puts 'Select train: '
    selected_train = gets.chomp.to_i

    puts "Select action for #{selected_train}: move to next(1) or to previous(2) station"
    action = gets.chomp.to_i
    case action
    when 1
      selected_train.run_next_station
    when 2
      selected_train.run_previous_station
    else
      'Entered option was not found.'
    end
  end
end

def assign_route_to_train
  if @trains.empty?
    puts 'There are no trains to set the route.'
  elsif @routes.empty?
    puts 'There are no routes to assign.'
  else
    selected_train = gets.chomp
    puts "Choose route to assign #{selected_train}"
    selected_route = gets.chomp
    selected_train = selected_route
    puts "Train #{selected_train} have #{selected_route} now."
  end
end

def add_stations_to_route
  puts 'Введите название станции'
  station = gets.chomp
  puts 'Введите начало маршрута'
  first_station = gets.chomp
  puts 'Введите конец маршрута'
  last_stations = gets.chomp
  route(first_station, last_stations).add_new_station(find_station(station))
end

def remove_stations_from_route
  puts 'Введите название станции'
  station = gets.chomp
  puts 'Введите начало маршрута'
  first_station = gets.chomp
  puts 'Введите конец маршрута'
  last_stations = gets.chomp
  route(first_station, last_stations).delete_station(find_station(station))
end

def select_route_stations
  if @stations.size < 2
    puts 'Для создания маршрута не хватает станций.'
  else
    puts 'Выберите первую станцию маршрута: '
    first_station = gets.chomp.to_i
    puts 'Выберите последнюю станцию маршрута:'
    stations = @stations.reject { |item| item == first_station }
    last_stations = gets.chomp.to_i
    create_route(first_station, last_stations)
  end
end

def create_route(first_station, last_stations)
  @routes << Route.new(first_station, last_stations)
  puts "Создан новый маршрут. Посмотреть все доступные: #{@routes}"
end

def create_train_selection
  puts 'Укажите номер нового поезда в формате NNNN-NN или NNNNNN (N - номер или буква): '
  train_number = gets.chomp
  puts 'Выберите грузовой (1) или пассажирский (2) поезд: '
  type = gets.chomp.to_i
  create_train(type, train_number)
end

def create_train(type, train_number)
  @trains << CargoCarriage.new if type == 1
  @trains << PassengerCarriage.new(train_number) if type == 2
  raise 'Тип поезда был введен неверно! Пожалуйста, введите 1 или 2.' unless type == 1 || type == 2

  puts "Поезд #{train_number} создан."
rescue StandardError => e
  puts e.message
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
  puts 'Напишите имя станции'
  name = gets.chomp
  puts " На станции #{name} находятся поезда: "
  trains = lambda do |train|
    puts train
    puts "№: #{train.num}, тип: #{train.type}, вагонов: #{train.carriages.length} "
  end

  def delete_carriage
    puts 'Укажите номер поезда'
    number = gets.chomp
    @trains.delete(num)
    puts "Поезд под номером #{num} удален "
  end

  def create_carriage
    puts 'Введите номер вагона'
    number = gets.chomp.to_i
    puts 'Введите тип вагона: passenger или cargo' |
         carriage_type = gets.chomp
    case carriage_type
    when :passenger
      puts 'Введите количество мест в вагоне'
      total_space = gets.chomp
      wagon = WagonPassenger.new(number, total_space)
    when :cargo
      puts 'Введите объём грузового вагона'
      total_space = gets.chomp
      wagon = WagonCargo.new(number, total_space)
    end
    puts 'Введите номер поезда, к которому нужно прицепить вагон'
    train_number = gets.chomp.to_i
    train(train_number).add_wagon(wagon)
    puts "#{wagon_type.capitalize} вагон #{number}успешно создан. " \
         "Вагон прицеплён к поезду #{train_number}."
  rescue RuntimeError => e
    puts e.message
    retry
  end
end

main = Main.new
main.run_main
