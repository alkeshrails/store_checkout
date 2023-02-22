require_relative 'Inventories/checkout.rb'
require_relative 'pricing_rules/two_for_one_promotion.rb'
require_relative 'pricing_rules/discount_promotion.rb'
require_relative './Inventories/inventory.rb'
require_relative './products/product.rb'

# Initialize objects
first_rule = TwoForOnePromotion.new('VOUCHER')
second_rule = DiscountPromotion.new('TSHIRT', 3, 1)
checkout = Checkout.new([ first_rule, second_rule])
inventory = checkout.inventory

puts 'List of Items in Inventory:'
puts inventory.list

puts '----------------------------------------------------------------------------------------------'

option = 0
while option != 2
  puts 'Add product to the cart ->'
  puts """
    1. Add Product
    2. exit
  """

  option = gets.chomp.to_i
  case option
  when 1
    puts 'Please enter code for product which you wanna add to the cart:'
    code = gets.chomp
    puts checkout.scan(code) ? 'The product was added to the cart successfully' : 'This product does not exist'
  when 2
    puts ''
  else
    puts 'Please select a correct option'
  end
end

puts '----------------------------------------------------------------------------------------------'

puts 'Total Amount of the cart:'
checkout.purchase_amount


