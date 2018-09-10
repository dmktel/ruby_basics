class CargoTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  def initialize(number)
    super(number, :cargo)
  end

  def add_wagon(wagon)
    if wagon.instance_of?(CargoWagon)
      super(wagon)
    else
      puts 'To cargo trains it is possible to add only cargo wagons!'
    end
  end
end
