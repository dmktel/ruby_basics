class Station
  attr_reader :name, :trains

  def initialize (name)
    @name = name
    @trains = []
    puts "Station #{name} has been created"
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
      puts "Trains type: '#{type}' at the station #{name}: "
      trains.each { |train| puts train.number if train.type == type }
    else type
      puts "Trains at the station #{name}: "
      trains.each { |train| puts train.number }
    end
  end

end

class Route
  attr_accessor :stations, :from, :to

  def initialize(from, to)
    @stations = [from, to]
    puts "Route '#{stations.first.name} - #{stations.last.name}' has been created"
  end

  def add_station(station)
    self.stations.insert(-2, station)
    puts "The station #{station.name} was added for route '#{stations.first.name} - #{stations.last.name}'"
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      puts "You can't remove first and last stations"
    else
      self.stations.delete(station)
      puts "The station #{station.name} was removed from route '#{stations.first.name} - #{stations.last.name}'"
    end
  end

  def list_stations
    puts "The route '#{stations.first.name} - #{stations.last.name}' include stations: "
    self.stations.each { |station| puts "#{station.name}"}
  end

end

class Train
  attr_accessor :speed, :number, :wagon_count, :station, :route
  attr_reader :type

  def initialize(number, type, wagon_count)
    @number = number
    @speed = 0
    @type = type
    @wagon_count = wagon_count
    puts "Train #{number} has been created, type - #{type}, wagons - #{wagon_count}"
  end

  def stop
    self.speed = 0
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
    self.route = route
    route.stations.first.get_train(self)
    puts "Route '#{route.stations.first.name} - #{route.stations.last.name}' has been added for train #{number}"
  end

  def go_to(station)
    if route.nil?
      Puts "Route is not set!"
    elsif route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "There isn't station #{station.name} at the route of train #{number}"
    end
  end

  def train_location
    if route.nil?
      Puts "Route is not set!"
    else
      station_index = route.stations.index(station)
      current_station = station.name
      prev_station = route.stations[station_index - 1].name if station_index != 0
      next_station = route.stations[station_index + 1].name if station_index != route.stations.size - 1
      puts "Current station: #{current_station}, previous station: #{prev_station}, next station: #{next_station}"
    end
  end

end

toronto = Station.new("Toronto")
ottawa = Station.new("Ottawa")
montreal = Station.new("Montreal")
route_tm = Route.new(toronto, montreal)
route_tm.add_station(ottawa)
train1 = Train.new("A", "pass", 1)
train2 = Train.new("B", "cargo", 2)
train1.take_route(route_tm)
