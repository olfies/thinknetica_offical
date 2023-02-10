class Train

  attr_reader :number, :type, :current_speed, :wagons, :current_station_index

  def initialize(number, type)
    @number = number
    @type = type
    @wagon = 0
    @wagons = []
    @route = []
    @speed = 0
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
  end

  def prev_station
    prev_station = @route.list_stations[@route.list_stations.index(@current_station) - 1]
  end
end
