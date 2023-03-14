require_relative 'station.rb'
require_relative 'route.rb'
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

    train_class = train[type]
    if train_class
      @trains.push(train_class.new(num))
      puts "Создан поезд типа #{type} номер #{num}"
    else
      puts 'Такого типа поезда нет'
    end
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
    num_station  = gets.chomp.to_i

    puts 'Укажите номер поезда'
    all_trains
    num_tr = gets.chomp.to_i
    @stations[num_station ].add_train(trains[num_tr])

    puts "На станцию #{num_station } Прибыл поезд #{trains[num_tr]}"
  end

  def all_stations
    @stations.each_with_index { |station, n| puts " #{n} #{station.name}" }
  end

  def list_trains_to_station
    puts 'Выберите номер станции'
    puts all_stations
    num_station  = gets.chomp.to_i
    puts "На станции #{all_stations[num_station ].name} находятся поезда: "
    @stations[num_station ].trains.each_with_index { |num, n| puts "#{n} #{num}" }
  end

  def list_trains_to_station
    puts 'Выберите номер станции'
    puts all_stations
    num_station  = gets.chomp.to_i
    selected_station = @stations[ation ]
    station = selected_station
    puts " На станции #{station.name} находятся поезда: "
    trains = |train|
      puts train
      puts "№: #{train.num}, тип: #{train.type}, вагонов: #{train.carriages.length} "
    end
    station.train_in(trains)
    end

  def list_carriages_to_train
    raise "Список поездов пуст, создайте поезд!" if @train.nil?
    puts 'Укажите номер поезда'
    all_trains
    num = gets.chomp.to_i
    selected_train = all_trains[num]
    train = selected_train
    n = 1
    train.carriages_in do |carriage|
      if train.type == :cargo
        puts " №#{n} Тип вагона: cargo"
        puts "Занято объема: #{carriage.volume}"
        puts "Осталось свободного объема: #{carriage.free_capacity}"
      else
        puts " №#{n} Тип вагона: passenger"
        puts "Занято мест: #{carriage.seats}"
        puts "Осталось мест: #{carriage.free_capacity}"
      end
      n += 1
    end
  end

  def load_carriage
    choice_loading_carriage
    puts 'Укажите поезд:'
    all_trains
    num_train = gets.chomp.to_i
    selected_train = all_trains[num_train]
    train = selected_train
    puts 'Укажите вагон'
    n = 1
    train.carriages_in do |carriage|
      if train.type == :cargo
        puts " №#{n} Тип вагона:cargo, занято: #{carriage.volume}"
        puts "Осталось свободного объема: #{carriage.free_capacity}"
      else
        puts " №#{n} Тип:passenger, занято: #{carriage.seats}"
        puts "Осталось мест: #{carriage.free_capacity}"
      end
      n += 1
    end
    num_carriage = gets.chomp.to_i
    selected_carriage = train.carriages[num_carriage - 1]

    puts "Вагон: #{selected_carriage}"
    if train.type == :cargo
      puts 'Укажите объем'
      value = gets.chomp.to_i
      selected_carriage.load(value)
    else
      puts 'Укажите количестко мест'
      value = gets.chomp.to_i
      selected_carriage.load(value)
    end
  end

  def create_station!(name)
    station = Station.new(name)
    @stations.push(station)
    puts "Создана станция #{name}"
  end

  def create_train!(type, num)
    train_class = train[type]
    if train_class
      @trains.push(train_class.new(num))
      puts "Создан поезд типа #{type} номер #{num}"
    else
      puts 'Такого типа поезда нет'
    end
  end

  def select_train
    fail 'Список поездов пуст, создайте поезд!' if @train.nil?
    puts 'Укажите номер поезда'
    all_trains
    num = gets.chomp.to_i
    selected_train = all_trains[num]
    selected_train
  end

  def all_trains
    @trains.each_with_index { |train, n| puts "#{n} #{train.num}" }
  end

  def selected_station
    fail 'Список станций пуст, создайте станцию!' if @stations.nil?
    puts 'Выберите номер станции'
    puts all_stations
    num = gets.chomp.to_i
    selected_station = @stations[num]
    selected_station
  end

  def all_stations
    @stations.each_with_index { |station, n| puts " #{n} #{station.name}" }
  end

end

controller = Controller.new
controller.run
