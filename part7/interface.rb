class Interface
  attr_reader :stations_list, :trains_list, :routes_list, :wagons_list

  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
    @wagons_list = []
  end

  MENU = {
    :list => {
      1 => "Create and manage stations",
      2 => "Create and manage trains",
      3 => "Create and manage routes",
      4 => "Create and manage wagons",
      0 => "Exit"
    },
    :stations => {
      1 => "Create station",
      2 => "Station list",
      3 => "Return to previous menu"
    },
    :trains => {
      1 => "Create train",
      2 => "Get route for train",
      3 => "Move forward by route",
      4 => "Move back by route",
      5 => "Watch trains list at station",
      6 => "All train list",
      7 => "Return to previous menu"
    },
    :routes => {
      1 => "Create Route",
      2 => "Add station to route",
      3 => "Remove station from route",
      4 => "All routes list",
      5 => "Return to previous menu"
    },
    :wagons => {
      1 => "Add wagon at train",
      2 => "Remove wagon from train",
      3 => "Train wagon counter",
      4 => "Return to previous menu"
    }
  }

  def menu(type)
    MENU[type].each {|key, value| puts "#{key}: #{value}"}
  end

  def input_choice
    print "Enter your choice: "
  end

  def input_station
    print "Enter station name: "
  end

  def exist_station_message(name)
    puts "Station #{name} already exist!"
  end

  def station_create_message(name)
    puts "Station #{name} has been created!"
  end

  def watch_stations
    @stations_list.each {|station| puts "#{station.name}"}
  end

  def input_train
    print "Enter train number: "
  end

  def input_type
    print "Enter type 'cargo' or 'pass': "
  end

  def exist_train_message(number)
    puts "Train #{number} already exist!"
  end

  def create_train_type(number, type)
    if type == "cargo"
      @trains_list << CargoTrain.new(number)
    elsif type == "pass"
      @trains_list << PassTrain.new(number)
    else
      puts "Error, you must enter 'cargo' or 'pass'!"
    end
  end


  def train_create_message(number)
    puts "Train #{number} has been created!"
  end

  def all_train_list
    @trains_list.each {|train| puts "#{train.number} #{train.type}"}
  end

  def input_first_station
    print "Enter first station: "
  end

  def input_last_station
    print "Enter last station: "
  end

  def no_station_message
    puts "No station! First create station."
  end

  def route_create_message(from, to)
    puts "Route '#{from} - #{to}' has been created!"
  end

  def all_routes_list
    @routes_list.each  do |route|
      index = @routes_list.index(route) + 1
      puts "#{index}: '#{route.stations.first.name} - #{route.stations.last.name}'"
    end
  end

  def input_route_numbre
    print "Enter route number: "
  end

  def no_train_message
    puts "No train! First create train."
  end

  def no_route_message
    puts "No route! First create route."
  end

  def train_no_route_message(number)
    puts "Train #{train.number} does not have route!"
  end

  def no_wagons_message
    puts "No wagons at train!"
  end

  def error_message
    puts "Enter another value"
  end

end
