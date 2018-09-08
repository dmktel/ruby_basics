require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include InstanceCounter
  include Manufacturer
  include Validation
  include Acсessors

  attr_reader :speed, :number, :route, :type, :wagons
  @@trains = {}
  validate :number, :presence
  validate :number, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    @@trains[number] = self
    register_instance
  end

  def accellerate(speed)
    @speed += speed if @speed <= 70
  end

  def brake(speed)
    @speed -= speed if @speed >  0
  end

  def add_wagon(wagon)
    @wagons.push(wagon) if @speed.zero?
  end

  def remove_wagon
    @wagons.delete_at(-1) if @speed.zero? && @wagons != []
  end

  def take_route(route)
    @route = route
    route.stations.first.get_train(self)
    @index = 0
  end

  def forward
    return unless next_station
    current_station.send_train(self)
    next_station.get_train(self)
    @index += 1 if @index < route.stations.size - 1
  end

  def back
    return unless prev_station
    current_station.send_train(self)
    prev_station.get_train(self)
    @index -= 1 if @index > 0
  end

  def current_station
    route.stations[@index]
  end

  def next_station
    route.stations[@index + 1] if @index < route.stations.size - 1
  end

  def prev_station
    route.stations[@index - 1] if @index > 0
  end

  def iterate_wagons
    @wagons.each { |wagon| yield(wagon) }
  end
end
