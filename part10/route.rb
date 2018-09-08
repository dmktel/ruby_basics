require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Route
  include InstanceCounter
  include Validation
  include Acсessors

  attr_reader :stations
  validate :stations, :kind, Station
  validate :stations, :same
  def initialize(from, to)
    @stations = [from, to]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      puts 'You can not remove first and last stations'
    else
      @stations.delete(station)
    end
  end

  def list_stations
    puts 'The route include stations '
    @stations.each { |station| puts station.name }
  end
end
