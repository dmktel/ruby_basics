class CargoWagon < Wagon
  attr_reader :filled

  def initialize (volume)
    @volume = volume
    @filled = 0
    super(:cargo)
  end

  def load_cargo(amount)
    raise "No free volume!" if @filled + amount > @volume
    @filled += amount
  end

  def free
    @volume - @filled
  end

end
