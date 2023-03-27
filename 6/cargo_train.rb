# frozen_string_literal: false

require_relative 'train.rb'
class CargoTrain < Train
  @trains = {}

  def initialize(num)
    super
    @type = :cargo
  end
end
