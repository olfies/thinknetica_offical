require_relative 'wagon.rb'
class CargoWagon < Wagon
  attr_accessor :type

  def initialize
    @type = :cargo
  end
end
