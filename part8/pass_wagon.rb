class PassWagon < Wagon

  def initialize(volume)
    super(:pass, volume)
  end

  def load(amount = 1)
    raise "No free places!" if @filled == @volume
    super(amount)
  end

  def free
    super
  end

end
