require_relative 'carriage'
class PassengerCarriage < Carriage
  attr_accessor :type

  def initialize
    @type = :passenger
    validate!
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
  rescue
    false
  end

end
