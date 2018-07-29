class Station
  attr_reader :name, :trains

  def initialize (name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
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
  end

  def accellerate(speed)
    @speed = @speed + speed if @speed <= 70
  end

  def brake(speed)
    @speed = @speed - speed if @speed >  0
  end

  def add_wagon
    if @speed == 0
      @wagon_count = wagon_count + 1
    end
  end

  def remove_wagon
    if @speed == 0 && wagon_count > 0
      @wagon_count = wagon_count - 1
    end
  end

  def take_route(route)
    @route = route
    route.stations.first.get_train(self)
    @current_station_index = 0
  end

  def forward
    if next_station
      current_station.send_train(self)
      next_station.get_train(self)
      @current_station_index += 1 if @current_station_index < route.stations.size - 1
    end
  end

  def back
    if current_station
      current_station.send_train(self)
      prev_station.get_train(self)
      @current_station_index -= 1 if @current_station_index > 0
    end
  end

  def current_station
    route.stations[@current_station_index]
  end

  def next_station
    route.stations[@current_station_index + 1] if @current_station_index < route.stations.size - 1
  end

  def prev_station
    route.stations[@current_station_index - 1] if @current_station_index > 0
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
