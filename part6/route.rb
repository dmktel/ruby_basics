require_relative 'instance_counter'

class Route
  include InstanceCounter
  
  attr_reader :stations, :from, :to

  def initialize(from, to)
    @stations = [from, to]
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

end
