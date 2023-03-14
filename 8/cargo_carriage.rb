class CargoCarriage < Carriage
  attr_accessor :volume, :type
  attr_reader   :taken_volume, :free_volume

  def initialize(volume)
    @volume = volume
    @type = :cargo
    @taken_volume = 0
    @free_volume = @volume
    validate!
  end

  def take_volume(volume)
    if free_volume?(volume)
      @taken_volume += volume
      @free_volume -= volume
    end
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

  def has_free_volume?(volume)
    raise "You can't take so much volume (free_volume = #{@free_volume})!" if (@free_volume - volume).negative?

    true
  end
end
