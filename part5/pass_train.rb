class PassTrain < Train
  def initialize (number)
    super(number, :pass)
  end
  def add_wagon(wagon)
    if wagon.instance_of?(PassWagon)
      super(wagon)
    else
      puts "To passenger trains it is possible to add only passenger wagons!"
    end
  end
end
