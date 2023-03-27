# frozen_string_literal: false

class Route
  attr_reader :list_stations

  def initialize(first_station, last_station)
    @list_stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) if station != @stations.first || station != @stations.last
  end

  def print_all_stations
    puts list_stations
  end
end
