# frozen_string_literal: true

require_relative 'inventory'
require_relative '../products/unit'

class Checkout
  attr_reader :total, :inventory, :units

  def initialize(pricing_rules)
    @rules = pricing_rules
    voucher = Product.new('VOUCHER', 'Voucher', 5.0)
    tshirt = Product.new('TSHIRT', 'T-Shirt', 20.0)
    mug = Product.new('MUG', 'Coffee Mug', 7.5)
    bag = Product.new('BAG', 'bag', 50.0)
    @inventory = Inventory.new(voucher,tshirt, mug, bag)
    @units = []
    @valid_codes = @inventory.valid_codes
  end

  def scan(code)
    if @valid_codes.include?(code)
      product = @inventory.find(code)
      unit = Unit.new(product.code, product.price)
      @units.push(unit)
      true
    else
      false
    end
  end

  def purchase_amount
    units = @units.map(&:code).join(', ')
    p units.size > 0 ? "Items purchased: #{units}" : 'Empty Cart'
    p "Total: #{self.total_amount}$"
  end

  def total_amount
    @rules.each{ |rule| rule.apply_promotion(@units) }
    @units.inject(0.0){ |total, item| total += item.price}
  end
end