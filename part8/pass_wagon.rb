class PassWagon < Wagon

  def initialize(volume)
    super(:pass, volume)
  end

  def load
    raise "No free places!" if @filled == @volume
    super(1)
  end

end
