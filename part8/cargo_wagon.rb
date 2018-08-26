class CargoWagon < Wagon

  def initialize(volume)
    super(:cargo, volume)
  end

  def load(amount)
    raise "No free volume!" if @filled + amount > @volume
    super(amount)
  end

  def free
    super
  end

end
