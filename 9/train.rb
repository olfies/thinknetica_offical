# frozen_string_literal: false

class Train
  attr_reader :carriage,
              :carriages,
              :speed,
              :current_station,
              :route,
              :type

  @trains = []

  def initialize(num, type)
    @num = num
    @train_number = []
    @type = type
    @carriage = 0
    @carriages = []
    @speed = 0
    @route = []
    @trains << self
  end

  def stop
    @speed = 0
  end

  def print_speed
    puts speed
  end

  def each_carriage
    @carriages.each { |carriage| yield(carriage) } if block_given?
    self
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

  def run_next_station
    return if run_next_station.nil?

    current_station.remove_train(self)

    @current_station += 1

    current_station.add_train(self)
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

  def speed_up(_speed_delta)
    @speed += speed
  end

  def brake_train
    @speed = 0
  end

  def relevant_wagon?(wagon)
    wagon.type == @type
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && relevant_wagon?(wagon)
  end

  def remove_wagon(wagon)
    return if @speed.nonzero?

    @wagons.delete(wagon)
  end

  def route=(route)
    @route = route
    @current_station = @route.list_stations.first
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def previous_station
    @route.stations[@current_station - 1] if @current_station.zero?
  end

  def current_station
    @route.stations[@current_station]
  end

  def run_next_station
    return if next_station.nil?

    current_station.remove_train(self)

    @current_station += 1

    current_station.add_train(self)
  end

  def run_previous_station
    return if get_previous_station.nil?

    current_station.remove_train(self)

    @current_station -= 1

    current_station.add_train(self)
  end

  private

  def next_station
    next_station = @route.list_stations[@route.list_stations.index(@current_station) + 1]

    [next_station]
  end

  def prev_station
    prev_station = @route.list_stations[@route.list_stations.index(@current_station) - 1]

    [prev_station]
  end
end
