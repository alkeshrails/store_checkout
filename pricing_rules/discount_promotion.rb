# frozen_string_literal: true

class DiscountPromotion
  attr_accessor :discount_per_unit
  attr_reader :code, :quantity

  def initialize(code, quantity, discount_per_unit)
    @code = code
    @quantity = quantity
    @discount_per_unit = discount_per_unit
  end

  def apply_promotion(units)
    purchase_units = units.select{ |i| i.code == code}
    if purchase_units.size >= quantity
      purchase_units.each{ |unit| unit.price -= discount_per_unit }
    end
  end
end
