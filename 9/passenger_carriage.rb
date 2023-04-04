# frozen_string_literal: false

require_relative 'carriage'
class PassengerCarriage < Carriage
  attr_accessor :type, :seats
  attr_reader   :taken_seats, :free_seats

  def initialize(seats)
    @seats = seats
    @taken_seats = 0
    @free_seats = @seats
  end

  def take_a_seat
    return unless valid?

    @taken_seats += 1
    @free_seats -= 1
  end
end
