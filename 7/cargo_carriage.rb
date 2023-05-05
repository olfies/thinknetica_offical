
require_relative 'carriage.rb'
class CargoCarriage < Carriage
  attr_accessor :type

  def initialize
    @type = :cargo
    validate!
  end

  protected

  def validate!
    raise "You can't create a carriage without volume!" if @volume.nil?
    raise "You can't create a carriage with zero volume!" if @volume <= 0




    true
  end

  def valid?
    validate!

  rescue StandardError
    false
  end

  def free_volume?(volume)
    raise "You can't take so much volume (free_volume = #{@free_volume})!" if (@free_volume - volume).negative?

    true
  end
end

  rescue
    false
  end

  def has_free_volume?(volume)
    raise "You can't take so much volume (free_volume = #{@free_volume})!" if (@free_volume - volume) < 0
    true
  end

end


