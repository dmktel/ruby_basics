class PassTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  def initialize(number)
    super(number, :pass)
  end

  def add_wagon(wagon)
    if wagon.instance_of?(PassWagon)
      super(wagon)
    else
      puts 'To passenger trains it is possible to add only passenger wagons!'
    end
  end
end
