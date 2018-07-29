class Station
  attr_reader :name, :trains

  def initialize (name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
    puts "The train #{train.number} arrived at the station #{name}"
  end

  def send_train(train)
    @trains.delete(train)
    puts "The train #{train.number} left from the station #{name}"
  end

  def list_train(type = nil)
    if type
      trains.each { |train| train.number if train.type == type }
    else
      trains.each { |train| train.number }
    end
  end

end

class Route
  attr_reader :stations, :from, :to

  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      puts "You can't remove first and last stations"
    else
      stations.delete(station)
    end
  end

  def list_stations
    puts "The route '#{stations.first.name} - #{stations.last.name}' include stations: "
    stations.each { |station| puts station.name}
  end

end

class Train
  attr_reader :speed, :number, :wagon_count, :route, :type

  def initialize(number, type, wagon_count)
    @number = number
    @speed = 0
    @type = type
    @wagon_count = wagon_count
    puts "Train #{number} has been created, type - #{type}, wagons - #{wagon_count}"
  end

  def accellerate(speed)
    @speed = @speed + speed if @speed <= 70
    puts @speed
  end

  def brake(speed)
    @speed = @speed - speed if @speed >  0
  end

  def add_wagon
    if @speed == 0
      self.wagon_count += 1
      puts "One has been added to train #{number}. #{wagon_count} in train"
    else
      puts "Can't add wagons on moving"
    end
  end

  def remove_wagon
    if wagon_count < 0
      puts "Train can't be without wagons"
    elsif @speed == 0
      self.wagon_count -= 1
      puts "One has been removed from train #{number}. #{wagon_count} in train"
    else
      puts "Can't remove wagons on moving"
    end
  end

  def take_route(route)
    @route = route
    route.stations.first.get_train(self)
    @station = route.stations.first
    @current_station_index = 0
    puts "Route '#{route.stations.first.name} - #{route.stations.last.name}' has been added for train #{number}"
  end

  def forward
    if route.nil?
      Puts "Route is not set!"
    elsif next_station
      current_station.send_train(self)
      next_station.get_train(self)
      @current_station_index += 1 if @current_station_index < route.stations.size - 1
    else
      puts "There isn't station #{station.name} at the route"
    end
  end

  def back
    if route.nil?
      Puts "Route is not set!"
    else
      current_station.send_train(self)
      prev_station.get_train(self)
      @current_station_index -= 1 if @current_station_index > 0
    end
  end

  def current_station
    if route.nil?
      Puts "Route is not set!"
    else
      @station = route.stations[@current_station_index]
    end
  end

  def next_station
    if route.nil?
      Puts "Route is not set!"
    else
      @station = route.stations[@current_station_index + 1] if @current_station_index < route.stations.size - 1
    end
  end

  def prev_station
    if route.nil?
      Puts "Route is not set!"
    else
      @station = route.stations[@current_station_index - 1] if @current_station_index > 0
    end
  end

end
=begin
toronto = Station.new("Toronto")
ottawa = Station.new("Ottawa")
montreal = Station.new("Montreal")
route_tm = Route.new(toronto, montreal)
route_tm.add_station(ottawa)
train1 = Train.new("A", "pass", 1)
train2 = Train.new("B", "cargo", 2)
train1.take_route(route_tm)
=end
