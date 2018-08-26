require_relative 'manufacturer'

class Wagon
  include Manufacturer

  attr_reader :type, :filled

  def initialize(type, volume)
    @type = type
    @volume = volume
    @filled = 0
  end

  def load(amount)
    @filled += amount
  end

  def free
    @volume - @filled
  end
end
