
class Interface

  CHOICE_LIST = {
    1 => "Create station",
    2 => "Create train",
    3 => "Create and manage route",
    4 => "Get route",
    5 => "Add wagons",
    6 => "Remove wagons",
    7 => "Move forward train by route",
    8 => "Move back train by route",
    9 => "Watch stations list",
    10 => "Watch trains list",
    11 => "All trains list",
    12 => "All routes list",
    0 => "Exit"
  }
  CHOICE_ROUTE = {
    1 => "Create Route",
    2 => "Add station to route",
    3 => "Remove station to route",
    4 => "Return to previous menu"
  }

  PUTS_LIST = {
    1 => "Enter your choice: ",
    2 => "Exit! Thanks for your attention",
    3 => "Enter first station of route: ",
    4 => "Enter last station of route: ",
    5 => "Enter station name you want to add to the route: ",
    6 => "Enter station name you want to remove to the route: ",
    7 => "Enter route number: ",
    8 => "Enter station name: ",
    9 => "Enter train number: ",
    10 => "Enter train type 'cargo' or 'pass': ",
    11 => "Error! you must enter 0..10",
    12 => "Error, you must enter 'cargo' or 'pass'!",
    14 => "No station or route",
    15 => "Error! you must enter 1..4",
    16 => "No train or route",
    17 => "No train",
    18 => "No wagons at train",
    19 => "No station"
  }

  attr_reader :stations_list, :trains_list, :routes_list
  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
  end

  def run
    CHOICE_LIST.each {|key, value| puts "#{key}: #{value}"}
    loop do
      print PUTS_LIST[1]
      choice = gets.to_i
      case choice
      when 0
        puts PUTS_LIST[2]
        break
      when 1
        print PUTS_LIST[8]
        name = gets.chomp
        create_station(name)
      when 2
        print PUTS_LIST[9]
        number = gets.to_i
        print PUTS_LIST[10]
        type = gets.chomp
        create_train(number, type)
      when 3
        loop do
          CHOICE_ROUTE.each {|key, value| puts "#{key}: #{value}"}
          print PUTS_LIST[1]
          choice = gets.to_i
          case choice
          when 1
            print PUTS_LIST[3]
            from = gets.chomp
            print PUTS_LIST[4]
            to = gets.chomp
            create_route(from, to)
          when 2
            print PUTS_LIST[7]
            route_number = gets.to_i
            print PUTS_LIST[5]
            name = gets.chomp
            add_station_route(route_number, name)
          when 3
            print PUTS_LIST[7]
            route_number = gets.to_i
            print PUTS_LIST[6]
            name = gets.chomp
            remove_station_route(route_number, name)
          when 4
            break
          else
            puts PUTS_LIST[15]
          end
        end
      when 4
        print PUTS_LIST[9]
        number = gets.to_i
        print PUTS_LIST[7]
        route_number = gets.to_i
        get_route(number, route_number)
      when 5
        print PUTS_LIST[9]
        number = gets.to_i
        add_car(number)
      when 6
        print PUTS_LIST[9]
        number = gets.to_i
        remove_car(number)
      when 7
        print PUTS_LIST[9]
        number = gets.to_i
        move_forward(number)
      when 8
        print PUTS_LIST[9]
        number = gets.to_i
        move_back(number)
      when 9
        watch_stations
      when 10
        print PUTS_LIST[8]
        name = gets.chomp
        watch_trains(name)
      when 11
        watch_all_trains
      when 12
        watch_routes
      else
        puts PUTS_LIST[11]
      end
    end
  end

private

  def create_station(name)
    @stations_list << Station.new(name)
  end

  def create_train(number, type)
    if type == "cargo"
      @trains_list << CargoTrain.new(number)
    elsif type == "pass"
      @trains_list << PassTrain.new(number)
    else
      puts PUTS_LIST[12]
    end
  end

  def create_route(from, to)
    first_station = @stations_list.detect {|station| station.name == from}
    last_station = @stations_list.detect {|station| station.name == to}
    if from.nil? && to.nil?
      puts PUTS_LIST[19]
    else
      routes_list << Route.new(first_station, last_station)

    end
  end

  def add_station_route(route_number, name)
    station = @stations_list.detect {|station| station.name == name}
    route = @routes_list[route_number - 1]
    if station.nil? && routes_list[route_number - 1].nil?
      puts PUTS_LIST[14]
    else
      route.add_station(station)
      route.list_stations
    end
  end

  def remove_station_route(route_number, name)
    station = @stations_list.detect {|station| station.name == name}
    route = @routes_list[route_number - 1]
    if station.nil? && routes_list[route_number - 1].nil?
      puts PUTS_LIST[14]
    else
      route.remove_station(station)
      route.list_stations
    end
  end

  def get_route(number, route_number)
    train = @trains_list[number - 1]
    route = @routes_list[route_number - 1]
    if train.nil? && route.nil?
      puts PUTS_LIST[16]
    else
      train.take_route(route)
    end
  end

  def add_car (number)
    train = @trains_list[number - 1]
    if train.nil?
      puts PUTS_LIST[17]
    elsif train.instance_of? CargoTrain
      train.add_wagon(CargoWagon.new)
    elsif train.instance_of? PassTrain
      train.add_wagon(PassWagon.new)
    end
  end

  def remove_car(number)
    train = @trains_list[number - 1]
    if train.nil?
      puts PUTS_LIST[17]
    elsif train.wagons.empty?
      puts PUTS_LIST[18]
    else
      train.remove_wagon(train.wagons.last)
    end
  end

  def move_forward(number)
    train = @trains_list[number - 1]
    if train.nil?
      puts PUTS_LIST[17]
    else
      train.forward
    end
  end

  def move_back(number)
    train = @trains_list[number - 1]
    if train.nil?
      puts PUTS_LIST[17]
    else
      train.back
    end
  end

  def watch_stations
    @stations_list.each {|station| puts "#{station.name}"}
  end

  def watch_trains(name)
    station = @stations_list.detect {|station| station.name == name}
    station.list_train
  end

  def watch_all_trains
    @trains_list.each {|train| puts "#{train.number} #{train.type}"}
  end

  def watch_routes
    @routes_list.each {|route| puts "#{route.stations}"}
  end
end
