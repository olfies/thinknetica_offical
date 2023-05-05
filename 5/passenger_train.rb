# frozen_string_literal: false

require_relative 'train.rb'
class PassengerTrain < Train
  @trains = {}

  def initialize(num)
    super
    @type = :passenger
  end
end
