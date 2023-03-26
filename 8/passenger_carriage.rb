require_relative 'carriage'
class PassengerCarriage < Carriage
  attr_accessor :type, :seats
  attr_reader   :taken_seats, :free_seats

  def initialize(seats)
    @seats = seats
    @taken_seats = 0
    @free_seats = @seats
    validate!
  end

  def take_a_seat
    return unless valid?
      @taken_seats += 1
      @free_seats -= 1
    end
  end

  protected

  def validate!
    raise "You can't create a carriage without any seat!" if @seats.nil?
    raise "You can't create a carriage with zero seats!" if @seats <= 0
    raise 'Sorry, all seats are taken!' if @taken_seats > @seats || @free_seats.zero?

    true
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
end
