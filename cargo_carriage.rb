require_relative 'carriage.rb'
class CargoCarriage < Carriage
  attr_accessor :type

  def initialize
    @type = :cargo
  end

end
