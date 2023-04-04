# frozen_string_literal: false

class CargoCarriage
  attr_accessor :volume, :type
  attr_reader   :taken_volume, :free_volume

  def initialize(volume)
    @volume = volume
    @type = :cargo
    @taken_volume = 0
    @free_volume = @volume
  end

  def take_volume(volume)
    return unless free_volume?(volume)

    @taken_volume += volume
    @free_volume -= volume
  end
