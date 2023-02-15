require_relative 'wagon.rb'
class PassengerWagon < Wagon
  attr_accessor :type

  def initialize(_num)
    @type = :passenger
  end
end
