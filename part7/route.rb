require_relative 'instance_counter'
require_relative 'valid'

class Route
  include InstanceCounter
  include Valid

  NAME_FORMAT = /^[a-zA-Z]+$/i

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
    raise "Can't add same stations twice" if same_stations
  end

  def same_stations
    @stations.first.name == @stations.last.name
  end

end
