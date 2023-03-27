# frozen_string_literal: false

require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
class Wagon
  attr_reader :type, :wagon_size, :number

  def initialize(wagon_type, size)
    @type = wagon_type
    @wagon_size = size
    @number = number141
  end
end
