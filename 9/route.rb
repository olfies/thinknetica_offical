# frozen_string_literal: false

class Route
  attr_accessor :list_stations

  def initialize(first, last)
    @list_stations = [first, last]
    validate!
  end

  def add_station(station)
    list_stations.insert(-2, station)
    puts "В маршрут была добавлена станция #{station}"
  end

  def delete_station(station)
    if Array # include?
      puts 'Это конечная станция, ее нельзя удалять!'
    else
      list_stations.delete(station)
      puts "Из маршрута была удалена станция #{station}"
    end
  end

  def print_all_stations
    puts list_stations
  end\

  private

  def valid_station?(station)
    station.instance_of?(Station)
  end

  def validate!
    raise "You can't create route without any station" if @stations.compact!.any?

    true
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
end
