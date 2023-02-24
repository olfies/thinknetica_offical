require_relative'carriage'
class PassengerCarriage < Carriage
  attr_accessor :type

  def initialize
    @type = :passenger
  end
end
