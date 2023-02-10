class Station
  attr_reader :train, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    @trains << train unless trains.include?(train)
  end

  def trains_by_type(type)
    @trains.select { |trains| train.type == type }
  end

  def delete(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def mid(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_mid(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end

  def list_stations
    stations.each { |item| puts "#{item.name}, #{name}" }
  end
end

class Train
  attr_reader :number, :type, :wagons, :initial_speed, :initial_station, :route

  def initialize(nuber, type, wagons)
    @nuber = number
    @type = type
    @wagons = wagons
    @initial_speed = 0
    @route = nil
  end

  def acceleration(value)
    @initial_speed += value if value.positive?
  end

  def brake(value)
    @initial_speed -= value if value <= @initial_speed && value.positive?
  end

  def attach_wagon
    @wagons += 1 if @initial_speed.zero?
  end

  def unhook_wagon
    @wagons -= 1 if @initial_speed.zero && @wagons.positive?
  end

  def getting_route(route)
    @route = route
    @current_station_index = 0
  end

  def move_forward
   @current_station_index += 1
   @initial_station.arrive(self)
  end

  def move_between
    return unless @route && prev_station
    current_station.depart(self)
    @station_index -= 1
    current_station.arrive(self)
  end

  def current_station
    stations[current_station_index]
  end

  def previous_station
    return unless @route
    return if @station_index < 1
    @route.route[@station_ind ex - 1]
  end

  def next_station
    return unless @route
    @route.route[@station_index + 1]
  end
end
