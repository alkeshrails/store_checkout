# frozen_string_literal: true
require 'byebug'

class TwoForOnePromotion
  def initialize(code)
    @code = code
  end

  def apply_promotion(units)
    purchase_units = units.select{ |i| i.code == @code}
    return unless purchase_units.size > 2 || units.size > 2

    purchase_units.each_slice(2) do |unit, free_unit|
      free_unit.price = 0 unless free_unit.nil?
    end
  end
end
