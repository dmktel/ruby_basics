require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'valid'

class Train
  include InstanceCounter
  include Manufacturer
  include Valid

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  attr_reader :speed, :number, :route, :type, :wagons
  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @speed = 0
    @type = type
    @wagons = []
    validate!
    @@trains[number] = self
    register_instance
  end

  def accellerate(speed)
    @speed = @speed + speed if @speed <= 70
  end

  def brake(speed)
    @speed = @speed - speed if @speed >  0
  end

  def add_wagon(wagon)
    if @speed == 0
      @wagons.push(wagon)
    end
  end

  def remove_wagon
    if @speed == 0 && @wagons != []
      @wagons.delete_at(-1)
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
    if prev_station
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

  def iterate_wagons
    @wagons.each{ |wagon| yield(wagon) }
  end

  protected

  def validate!
    raise "Train number can't be blank!" if number.nil?
    raise "Wrong train format! Use (ххххх or ххх-хх)" if number !~ NUMBER_FORMAT
    raise "Train type can't be blank!" if type.empty?
    raise "You need to input 'cargo' or 'pass'" unless [:cargo, :pass].include?(type)
  end

end
