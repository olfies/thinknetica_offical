require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
class Train
  attr_reader :carriage,
              :carriages,
              :speed,
              :current_station,
              :route
  validate :type
  validate :number

  @@trains = []

  def initialize(num)
    @num = num
    @type = type
    @carriage = 0
    @carriages = []
    @speed = 0
    @route = []
    @@trains << self
    validate_new_train!
    self.class.trains[num] = self
    validate!
  end

  def stop
    @speed = 0
  end

  def print_speed
    puts speed
  end

  def train_in(block)
    @trains.values.flatten.each do |trains|
    @trains.values.flatten.each(&block)
    block.call(trains)
    end
  end

  def add_carriage(carriage)
    puts 'Cначала остановите поезд!' if @speed != 0
    if carriage.type != @type
      puts 'Тип поезда и вагона не совпадают'
    else
      @carriages.push(carriage)
      puts "К поезду #{num} был добавлен вагон, в составе #{carriages.size} вагонов"
    end
  end

  def delete_carriage(carriage)
    puts 'Cначала остановите поезд!' if @speed != 0
    if carriage.type != @type
      puts 'Тип поезда и вагона не совпадают'
    else
      @carriages.delete(carriage)
      puts "Удален вагон, в составе осталось #{carriages.size} вагона"
    end
  end

  def accept_route(route)
    @route = route
    @current_station = @route.list_stations.first
    puts "Поезд находится на станции #{current_station} и поедет по марщруту #{@route.list_stations.first} - #{@route.list_stations.last}"
  end

  def print_next_station
    if @current_station == @route.list_stations.last
      puts 'Это последняя станция'
    else
      next_station
      puts "Следущая станция #{next_station}"
    end
  end

  def print_prev_station
    if @current_station == @route.list_stations.first
      puts 'Это первая станция'
    else
      prev_station
      puts "Предыдущая станция #{prev_station}"
    end
  end

  def go_next_station
    @current_station = next_station
    puts "Поезд приехал на станцию #{@current_station}"
    puts 'Это конечная станция, можно ехать обратно' if @current_station == @route.list_stations.last
  end

  def go_prev_station
    if @current_station == @route.list_stations.first
      puts 'Это первая станция, можно ехать только вперед'
    elsif @current_station != @route.list_stations.last
      puts 'Это еще не конечная станция, едем вперед'
    else
      puts "Поезд приехал на станцию #{current_station}"
    end
  end

  def self.find(num)
    @trains.find { |train| train.num == num }
  end

  private

  def next_station
    next_station = @route.list_stations[@route.list_stations.index(@current_station) + 1]
  end

  def prev_station
    prev_station = @route.list_stations[@route.list_stations.index(@current_station) - 1]
  end

  def valid_route?(route)
    route.instance_of?(Route)
  end

  def valid_carriage?(carriage)
    carriage.is_a?(Carriage)
  end

  def validate!
    raise "Speed can't be less than zero!" if @speed < 0
    raise "You can't create train without any carriage!" if @carriages.nil?

    true
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
end
