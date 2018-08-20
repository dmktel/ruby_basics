require_relative 'instance_counter'
require_relative 'valid'

class Route
  include InstanceCounter
  include Valid

  NAME_FORMAT = /^[a-zA-Z]$/i

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

protected

  def validate!
    raise "Station name can't be blank!" if from.nil? && to.nil?
    raise "Station name can't be at least 2 symbols" if from.length < 2 && to.length < 2
    raise "You need to use English alphabet!" if from !~ NAME_FORMAT && to !~ NAME_FORMAT
    true
  end

end
