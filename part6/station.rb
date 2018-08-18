require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains
  @@stations = []
  
  def self.all
    @@stations
  end
  
  def initialize(name)
    @name = name
    @trains = []
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

end
