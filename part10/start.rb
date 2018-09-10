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
        create_station
      when 2
        train_at_station
      when 3
        @interface.watch_stations
      when 4
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
        create_train
      when 2
        give_route
      when 3
        move_forward
      when 4
        move_back
      when 5
        @interface.all_train_list
      when 6
        train_info_list
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
        create_route
      when 2
        add_station_route
      when 3
        remove_station_route
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
        add_wagon_train
      when 2
        remove_wagon_train
      when 3
        load_wagon
      when 4
        wagons_counter
      when 5
        break
      else
        @interface.error_message
      end
    end
  end

  def create_station
    @interface.input_station
    name = gets.chomp
    if exist_station?(name)
      @interface.exist_station_message(name)
    else
      @interface.stations_list << Station.new(name)
      @interface.station_create_message(name)
    end
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  def train_at_station
    @interface.watch_stations
    @interface.input_station
    name = gets.chomp
    train_station(name)
  end

  def train_station(name)
    station = exist_station?(name)
    if station.nil?
      station_nil
    else
      station.iterate_trains do |train|
        puts "##{train.number} #{train.type} wagons: #{train.wagons.length}"
      end
    end
  end

  def create_cargo_train
    @interface.input_train
    number = gets.chomp
    cargo_train_check(number)
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  def cargo_train_check(number)
    if exist_train?(number)
      @interface.exist_train_message(number)
    else
      @interface.trains_list << CargoTrain.new(number)
    end
  end

  def create_pass_train
    @interface.input_train
    number = gets.chomp
    pass_train_check(number)
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  def pass_train_check(number)
    if exist_train?(number)
      @interface.exist_train_message(number)
    else
      @interface.trains_list << PassTrain.new(number)
    end
  end

  def create_train
      @interface.type_menu
      @interface.input_choice
      choice = gets.to_i
      create_train_new(choice)
  end

  def create_train_new(choice)
    if choice == 1
      create_cargo_train
    elsif choice == 2
      create_pass_train
    else
      @interface.error_message
      menu_trains
    end
  end

  def create_route
    input_from
    from = gets.chomp
    input_to
    to = gets.chomp
    create_route_new(from, to)
  end

  def create_route_new(from, to)
    if exist_station?(from).nil? && exist_station?(to).nil?
      station_nil
    else
      route_new(from, to)
    end
  end

  def route_new(from, to)
    first_station = exist_station?(from)
    last_station = exist_station?(to)
    @interface.routes_list << Route.new(first_station, last_station)
    @interface.route_create_message(from, to)
  end

  def add_station(route_number, name)
    route = @interface.routes_list[route_number - 1]
    station = exist_station?(name)
    if route.nil? || station.nil?
      station_route_nil
    else
      route.add_station(station)
      route.list_stations
    end
  end

  def add_station_route
    input_route_number
    route_number = gets.to_i
    input_station_name
    name = gets.chomp
    add_station(route_number, name)
  end

  def remove_station(route_number, name)
    route = @interface.routes_list[route_number - 1]
    station = exist_station?(name)
    if route.nil? || station.nil?
      station_route_nil
    else
      route.remove_station(station)
      route.list_stations
    end
  end

  def remove_station_route
    input_route_number
    route_number = gets.to_i
    input_station_name
    name = gets.chomp
    remove_station(route_number, name)
  end

  def give_route
    @interface.all_train_list
    @interface.input_train
    number = gets.chomp
    @interface.all_routes_list
    @interface.input_route_numbre
    route_number = gets.to_i
    give_route_train(number, route_number)
  end

  def give_route_train(number, route_number)
    train = exist_train?(number)
    route = @interface.routes_list[route_number - 1]
    if train.nil? || route.nil?
      @interface.train_without_route_message
      run
    else
      train.take_route(route)
    end
  end

  def move_forward
    input_train_number
    number = gets.chomp
    forward(number)
  end

  def forward(number)
    train = exist_train?(number)
    if train.nil? || train.route.nil?
      train_without_route
    else
      train.forward
    end
  end

  def move_back
    input_train_number
    number = gets.chomp
    back(number)
  end

  def back(number)
    train = exist_train?(number)
    if train.nil? || train.route.nil?
      train_without_route
    else
      train.back
    end
  end

  def train_info_list
    input_train_number
    number = gets.chomp
    info_train(number)
  end

  def info_train(number)
    train = exist_train?(number)
    if train.nil?
      train_nil
    else
      output_cargo_wagon(number) if train.type == :cargo
      output_pass_wagon(number) if train.type == :pass
    end
  end

  def trains_station_list(name)
    station = exist_station?(name)
    station.list_train
  end

  def add_wagon(number, volume)
    train = exist_train?(number)
    if train.nil?
      train_nil
    else
      add_cargo_wagon(number, volume) if train.type == :cargo
      add_pass_wagon(number, volume) if train.type == :pass
    end
  end

  def add_wagon_train
    input_train_number
    number = gets.chomp
    @interface.wagon_volume_input
    volume = gets.to_i
    add_wagon(number, volume)
  end

  def add_cargo_wagon(number, volume)
    train = exist_train?(number)
    wagon = CargoWagon.new(volume)
    train.add_wagon(wagon)
  end

  def add_pass_wagon(number, volume)
    train = exist_train?(number)
    wagon = PassWagon.new(volume)
    train.add_wagon(wagon)
  end

  def remove_wagon_train
    input_train_number
    number = gets.chomp
    delete_wagon(number)
  end

  def delete_wagon(number)
    train = exist_train?(number)
    if train.nil? || train.wagons.empty?
      train_wagon_nil
    else
      train.remove_wagon
    end
  end

  def load_wagon
    input_train_number
    number = gets.chomp
    load_wagon_make(number)
  end

  def load_wagon_make(number)
    train = exist_train?(number)
    if train.nil? || train.wagons.empty?
      train_wagon_nil
    else
      wagon_load(number)
    end
  end

  def load_cargo_wagon(number, index)
    wagon = detect_wagon(number, index)
    @interface.wagon_volume_input
    volume = gets.to_i
    wagon.load(volume)
  end

  def wagon_load(number)
    info_train(number)
    input_wagon_index
    index = gets.to_i
    loading(number, index)
  end

  def loading(number, index)
    train = exist_train?(number)
    wagon = detect_wagon(number, index)
    if wagon.nil?
      wagon_nil
    else
      load_cargo_wagon(number, index) if train.type == :cargo
      wagon.load if train.type == :pass
    end
  end

  def wagons_counter
    input_train_number
    number = gets.chomp
    train = exist_train?(number)
    if train.nil?
      train_nil
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

  def detect_wagon(number, index)
    train = exist_train?(number)
    train.wagons.detect { |wagon| train.wagons.index(wagon) + 1 == index }
  end

  def train_wagon_nil
    @interface.no_train_wagons_message
    run
  end

  def output_cargo_wagon(number)
    train = exist_train?(number)
    train.iterate_wagons do |wagon|
      puts "##{train.wagons.index(wagon) + 1} #{train.type} filled volume:\
      #{wagon.filled} free volume: #{wagon.free}"
    end
  end

  def output_pass_wagon(number)
    train = exist_train?(number)
    train.iterate_wagons do |wagon|
      puts "##{train.wagons.index(wagon) + 1} #{train.type} filled places:\
      #{wagon.filled} free places: #{wagon.free}"
    end
  end

  def train_nil
    @interface.no_train_message
    run
  end

  def station_nil
    @interface.no_station_message
    run
  end

  def station_route_nil
    @interface.no_station_route_message
    run
  end

  def train_route_nil
    @interface.no_train_route_message
    run
  end

  def train_without_route
    @interface.train_without_route_message
    run
  end

  def input_train_number
    @interface.all_train_list
    @interface.input_train
  end

  def input_from
    @interface.watch_stations
    @interface.input_first_station
  end

  def input_to
    @interface.watch_stations
    @interface.input_last_station
  end

  def input_route_number
    @interface.all_routes_list
    @interface.input_route_numbre
  end

  def input_station_name
    @interface.watch_stations
    @interface.input_station
  end

  def input_wagon_index
    @interface.wagon_index_input
  end

  def wagon_nil
    @interface.error_message
    run
  end
end
