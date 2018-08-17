class Start

  def initialize
    @interface = Interface.new
  end

  def run
    loop do
      @interface.menu(:list)
      @interface.input_choice
      choice = gets.to_i
      case choice
      when 1
        menu_stations
      when 2
        menu_trains
      when 3
        menu_routes
      when 4
        menu_wagons
      when 0
        break
      else
        @interface.error_message
      end
    end
  end

  def menu_stations
    loop do
      @interface.menu(:stations)
      @interface.input_choice
      choice = gets.to_i
      case choice
      when 1
        @interface.input_station
        name = gets.chomp
        create_station(name)
      when 2
        @interface.watch_stations
      when 3
        break
      else
        @interface.error_message
      end
    end
  end

  def menu_trains
    loop do
      @interface.menu(:trains)
      @interface.input_choice
      choice = gets.to_i
      case choice
      when 1
        @interface.input_train
        number = gets.to_i
        @interface.input_type
        type = gets.chomp
        create_train(number, type)
      when 2
        @interface.all_train_list
        @interface.input_train
        number = gets.to_i
        @interface.all_routes_list
        @interface.input_route_numbre
        route_number = gets.to_i
        get_route(number, route_number)
      when 3
        @interface.all_train_list
        @interface.input_train
        number = gets.to_i
        move_forward(number)
      when 4
        @interface.all_train_list
        @interface.input_train
        number = gets.to_i
        move_back(number)
      when 5
        @interface.watch_stations
        @interface.input_station
        name = gets.chomp
        trains_station_list(name)
      when 6
        @interface.all_train_list
      when 7
        break
      else
        @interface.error_message
      end
    end
  end

  def menu_routes
    loop do
      @interface.menu(:routes)
      @interface.input_choice
      choice = gets.to_i
      case choice
      when 1
        @interface.watch_stations
        @interface.input_first_station
        from = gets.chomp
        @interface.watch_stations
        @interface.input_last_station
        to = gets.chomp
        create_route(from, to)
      when 2
        @interface.all_routes_list
        @interface.input_route_numbre
        route_number = gets.to_i
        @interface.watch_stations
        @interface.input_station
        name = gets.chomp
        add_station_route(route_number, name)
      when 3
        @interface.all_routes_list
        @interface.input_route_numbre
        route_number = gets.to_i
        @interface.watch_stations
        @interface.input_station
        name = gets.chomp
        remove_station_route(route_number, name)
      when 4
        @interface.all_routes_list
      when 5
        break
      else
        @interface.error_message
      end
    end
  end

  def menu_wagons
    loop do
      @interface.menu(:wagons)
      @interface.input_choice
      choice = gets.to_i
      case choice
      when 1
        @interface.all_train_list
        @interface.input_train
        number = gets.to_i
        add_wagon_train(number)
      when 2
        @interface.all_train_list
        @interface.input_train
        number = gets.to_i
        remove_wagon_train(number)
      when 3
        @interface.all_train_list
        @interface.input_train
        number = gets.to_i
        wagons_counter(number)
      when 4
        break
      else
        @interface.error_message
      end
    end
  end



  def create_station(name)
    if exist_station?(name)
      @interface.exist_station_message(name)
    else
      @interface.stations_list << Station.new(name)
      @interface.station_create_message(name)
    end
  end

  def create_train(number, type)
    if exist_train?(number)
       @interface.exist_train_message(number)
    else
       @interface.create_train_type(number, type)
       @interface.train_create_message(number)
    end
  end

  def create_route(from, to)
    name = from
    first_station = exist_station?(name)
    name = to
    last_station = exist_station?(name)
    if first_station.nil? && last_station.nil?
      @interface.no_station_message
      menu_stations
    else
      @interface.routes_list << Route.new(first_station, last_station)
      @interface.route_create_message(from, to)
    end
  end

  def add_station_route(route_number, name)
    route = @interface.routes_list[route_number - 1]
    station = exist_station?(name)
    if route.nil?
      @interface.no_route_message
      menu_routes
    elsif station.nil?
      @interface.no_station_message
      menu_stations
    else
      route.add_station(station)
      route.list_stations
    end
  end

  def remove_station_route(route_number, name)
    route = @interface.routes_list[route_number - 1]
    station = exist_station?(name)
    if route.nil?
      @interface.no_route_message
      menu_routes
    elsif station.nil?
      @interface.no_station_message
      menu_stations
    else
      route.remove_station(station)
      route.list_stations
    end
  end
 
  def get_route(number, route_number)
    train = exist_train?(number)
    route = @interface.routes_list[route_number - 1]
    if train.nil?
      @interface.no_train_message
      menu_trains
    elsif route.nil?
      @interface.no_route_message
      menu_routes
    else
      train.take_route(route)
    end
  end

  def move_forward(number)
    train = exist_train?(number)
    if train.nil?
      @interface.no_train_message
      menu_trains
    elsif train.route.nil?
      @interface.train_no_route_message(number)
      menu_trains
    else
      train.forward
    end
  end

  def move_back(number)
    train = exist_train?(number)
    if train.nil?
      @interface.no_train_message
      menu_trains
    elsif train.route.nil?
      @interface.train_no_route_message(number)
      menu_trains
    else
      train.back
    end
  end

  def trains_station_list(name)
    station = exist_station?(name)
    station.list_train
  end

  def add_wagon_train(number)
    train = exist_train?(number)
    if train.nil?
      @interface.no_train_message
      menu_trains
    elsif train.type == :cargo
      wagon = CargoWagon.new
      train.add_wagon(wagon)
    elsif train.type == :pass
      wagon = PassWagon.new
      train.add_wagon(wagon)
    end
  end

  def remove_wagon_train(number)
    train = exist_train?(number)
    if train.nil?
      @interface.no_train_message
      menu_trains
    elsif train.wagons.empty?
      @interface.no_wagons_message
    else
      train.remove_wagon
    end
  end

  def wagons_counter(number)
    train = exist_train?(number)
    if train.nil?
      @interface.no_train_message
      menu_trains
    else
      count = train.wagons.length
      puts "Train #{train.number} has #{count} wagons"
    end
  end

  def exist_train?(number)
    @interface.trains_list.detect { |train| train.number == number }
  end

  def exist_station?(name)
    @interface.stations_list.detect { |station| station.name == name }
  end

end
