class PassWagon < Wagon
  attr_reader :filled

  def initialize(volume)
    @volume = volume
    @filled = 0
    super(:pass)
  end

  def load_pass(amount)
    raise "No free places!" if @filled == @volume
    @filled += 1
  end

  def free
    @volume - @filled
  end

end
