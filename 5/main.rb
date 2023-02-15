require_relative 'train.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'wagon.rb'

require 'pry'

class Main
  def select_actions_menu
    puts <<-HEREDOC
          Select action from menu:
          Stations:
            (1)Create station
            (2)List of stations
          Routes:
            (3)Create route
            (4)Edit route
            (5)Set route to the train
          Trains:
            (6)Create train
            (7)Add/remove wagons to train
            (8)Move train to the station
            (9)List trains on selected station
            (10) Exit
    HEREDOC
    run_action(gets.chomp)
  end

  def run_action(action)
    case action.to_i
    when 1
      create_station
    when 2
      list_all_stations
    when 3
      create_route
    when 4
      edit_route
    when 5
      assign_route_to_train
    when 6
      create_train
    when 7
      edit_train_wagons
    when 8
      move_train
    when 9
      show_all_trains_on_station
    when 10
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

  def list_all_stations
    all_stations = @stations.map(&:name)

    p all_stations.join(',')
  end

  def create_station
    puts 'Please provide station name:'
    station_name = gets.chomp
    if !station_name.empty?
      @stations << Station.new(station_name)
      puts "Station '#{station_name}' was created. See all available: #{@stations.join(',')} "
    else
      puts 'Input is empty. Please, try again.'
    end
  end

  def create_train
    puts 'Provide new train number: '
    train_number = gets.chomp
    puts 'Select cargo (1) or passenger(2) train: '
    type = gets.chomp
    @trains << CargoTrain.new(train_number) if type == '1'
    @trains << PassengerTrain.new(train_number) if type == '2'
    puts "Train #{train_number} was created. See all available: #{@trains.join(', ')}"
  end

  def edit_train_wagons
    if @trains.empty?
      puts 'There are no trains yet.'
      return
    end
    puts 'Select train: '
    selected_train = select_from_array(@trains)
    puts 'Select action with train: add wagon(1), remove wagon(2)'
    action = gets.chomp.to_i
    case action
    when 1 then
      new_wagon = create_wagon
      selected_train.add_wagon(new_wagon)
    when 2 then
      puts 'Select wagon from available: '
      selected_wagon = select_from_array(selected_train.wagons)
      selected_train.remove_wagon(selected_wagon)
      puts "In the train #{selected_train} left #{selected_train.wagons} wagons"
    else
      puts 'Input was incorrect. Please try again.'
    end
  end

  def create_route
    if @stations.size < 2
      puts 'There are not enough stations to create a route.'
    else
      puts 'Select first station of route:'

      first_station = select_from_array(@stations)
      puts 'Select last station of route:'

      stations = @stations.reject { |item| item == first_station }
      last_station = select_from_array(stations)

      @routes << Route.new(first_station, last_station)
      puts "New route was created. See all available: #{@routes}"
    end
  end

  def edit_route
    if @routes.empty?
      puts 'There are no routes to edit'
    else
      puts 'Select route to edit: '
      selected_route = select_from_array(@routes)
      puts 'Select action with route: add station(1), remove station(2)'
      action = gets.chomp.to_i
      case action
      when 1
        add_stations_to_route(selected_route)
      when 2
        remove_stations_from_route(selected_route)
      else
        puts 'Input was incorrect. PLease try again.'
      end
    end
  end

  def add_stations_to_route(route)
    stations = @stations - route.stations
    if stations.empty?
      puts 'All available stations are in the current route.'
    else
      selected_station = select_from_array(stations)
      route.add_station(selected_station)
      puts "Station was added to the route: #{route}. See updated route: #{route.stations}"
    end
  end

  def remove_stations_from_route(route)
    if route.stations.empty?
      puts "There are no stations to remove in '#{route.name}' route"
    else
      selected_station = select_from_array(route.stations)
      route.remove_station(selected_station)
      puts "Station was removed from route: #{route}. See updated route: #{route.stations}"
    end
  end

  def move_train
    if @trains.empty?
      puts 'There are no trains to move. Please, create one.'
    else
      puts 'Select train: '
      selected_train = select_from_array(@trains)

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

  def show_all_trains_on_station
    puts 'Please select station to show all trains.'
    station = select_from_array(@stations)
    puts "All trains on the station #{station.trains}"
  end
end

main = Main.new
main.run_main
