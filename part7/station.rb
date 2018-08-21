require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid

  NAME_FORMAT = /^[a-zA-Z]+$/i

  attr_reader :name, :trains
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def list_train
    trains.each { |train| puts "#{train.number} #{train.type}" }
  end

  protected

  def validate!
    raise "Station name can't be blank!" if name.nil? || name.empty?
    raise "Station name can't be at least 2 symbols" if name.length < 2
    raise "You need to use English alphabet!" if name !~ NAME_FORMAT
  end

end
