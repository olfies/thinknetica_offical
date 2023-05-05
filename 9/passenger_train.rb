# frozen_string_literal: false

class PassengerTrain < Train
  @trains = {}

  def initialize(num)
    super
    @type = :passenger
  end
end
