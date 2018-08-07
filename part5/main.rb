require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargotrain'
require_relative 'passtrain'
require_relative 'wagon'
require_relative 'cargowagon'
require_relative 'passwagon'
require_relative 'interface'


class Menu
  attr_reader :interface
  def initialize
    @interface = Interface.new
  end
end
