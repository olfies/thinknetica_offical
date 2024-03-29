
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'carriage.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passenger_carriage.rb'

class Controller
  attr_accessor :stations,
                :trains

  def initialize
    @stations = []
    @trains = []
  end

  def run
    puts 'Что вы хотите сделать?'
    action = gets.chomp
    case action
    when '1' then new_station
    when '2' then new_train
    when '3' then add_carriage
    when '4' then delete_carriage
    when '5' then add_train_to_station
    when '6' then all_stations
    when '7' then list_trains_to_station
    when '8' then exit
    end
  end

  private

  def new_station
    puts 'Укажите имя станции:'
    name = gets.chomp
    station = Station.new(name)
    @stations.push(station)
    puts "Создана станция #{name}"
  end

  def new_train
    puts 'Укажите тип поезда (cargo или passenger)'
    type = gets.chomp.to_sym
    puts 'Укажите номер поезда'
    num = gets.chomp

    train_class = TRAIN_TYPES[type]
    if train_class
      @trains.push(train_class.new(num))
      puts "Создан поезд типа #{type} номер #{num}"
    else
      puts 'Такого типа поезда нет'
    end


  def all_trains
    @trains.each_with_index { |train, n| puts "#{n} #{train.num}" }
  end

  def add_carriage
    puts 'Укажите номер поезда'
    all_trains
    num = gets.chomp.to_i
    carriage_type = Carriage[@trains[num].type]
    if carriage_type
      @trains[num].carriages.push(carriage_type.new)
      puts "Этот поезд типа #{@trains[num].type}, к нему будет добавлен вагон типа #{carriage_type}"
    else
      puts 'Такого поезда нет'
    end
  end

  def delete_carriage
    puts 'Укажите номер поезда'
    all_trains
    num = gets.chomp
    @trains.carriage.delete(num)
  end

  def add_train_to_station
    puts 'Выберите номер станции к которой хотите добавить поезд'
    puts all_stations
    num_st = gets.chomp.to_i

    puts 'Укажите номер поезда'
    all_trains
    num_tr = gets.chomp.to_i
    @stations[num_st].add_train(trains[num_tr])

    puts "На станцию #{num_st} Прибыл поезд #{trains[num_tr]}"
  end

  def all_stations
    @stations.each_with_index { |station, n| puts " #{n} #{station.name}" }
  end

  def list_trains_to_station
    puts 'Выберите номер станции'
    puts all_stations
    num_st = gets.chomp.to_i
    puts "На станции #{all_stations[num_st].name} находятся поезда: "
    @stations[num_st].trains.each_with_index { |num, n| puts "#{n} #{num}" }
  end
end

controller = Controller.new
controller.run
