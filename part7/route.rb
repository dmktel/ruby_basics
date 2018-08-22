require_relative 'instance_counter'
require_relative 'valid'

class Route
  include InstanceCounter
  include Valid

  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
    validate!
    register_instance
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

protected

  def validate!
    raise "Input isn't the type of Station" unless check_class!(stations.first)
    raise "Input isn't the type of Station" unless check_class!(stations.last)
    raise "Can't add same stations twice" if check_equal!
  end

  def check_class!(station)
    station.instance_of?(Station)
  end

  def check_equal!
    @stations.first == @stations.last
  end

end
