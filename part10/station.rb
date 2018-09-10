require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  extend Acсessors
  attr_accessor_with_history :name
  attr_reader :name, :trains
  validate :name, :presence
  validate :name, :format, /^[a-zA-Z]+$/i
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

  def iterate_trains
    @trains.each { |train| yield(train) }
  end
end
