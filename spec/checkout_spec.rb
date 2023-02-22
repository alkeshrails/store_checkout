# frozen_string_literal: true

require_relative '../inventories/checkout'
require_relative '../pricing_rules/two_for_one_promotion'
require_relative '../pricing_rules/discount_promotion'

RSpec.describe :checkout do
  let(:first_rule) { TwoForOnePromotion.new('VOUCHER') }
  let(:second_rule) { DiscountPromotion.new('TSHIRT', 3, 1) }
  let(:products) do
    [
      Product.new(code: 'VOUCHER', name: 'Voucher', price: 5.0),
      Product.new(code: 'TSHIRT', name: 'T-Shirt', price: 20.0),
      Product.new(code: 'MUG', name: 'Mug', price: 7.50),
      Product.new(code: 'BAG', name: 'bag', price: 50.0)
    ]
  end
  let(:checkout) { Checkout.new([first_rule, second_rule]) }

  describe 'scan or add products to cart' do
    it 'should add valid products to cart successfully' do
      expect(checkout.scan('BAG')).to eql(true)
    end

    it 'should not add invalid successfully' do
      expect(checkout.scan('Bagg')).to eql(false)
    end
  end

  describe 'purchase amount' do
    it 'should show total purcahse amount with purchased items' do
      checkout.scan('VOUCHER')
      checkout.scan('VOUCHER')
      expect(checkout.purchase_amount).to eql('Total: 10.0$')
    end

    it 'should return Total: 0.0$ amount' do
      expect(checkout.purchase_amount).to eql('Total: 0.0$')
    end
  end

  describe 'two for one promotions' do
    it 'should add promotions if two vouchers are added with another product' do
      checkout.scan('VOUCHER')
      checkout.scan('VOUCHER')
      checkout.scan('TSHIRT')
      expect(checkout.purchase_amount).to eql('Total: 25.0$')
    end

    it 'should not apply promotions for cart which not contains more than 1 voucher' do
      checkout.scan('VOUCHER')
      checkout.scan('MUG')
      checkout.scan('TSHIRT')
      expect(checkout.purchase_amount).to eql('Total: 32.5$')
    end
  end

  describe 'discount of 1$ for more then 2 t-shirts promotions' do
    it 'should add promotions for more than 3 t-shirts' do
      checkout.scan('TSHIRT')
      checkout.scan('TSHIRT')
      checkout.scan('TSHIRT')
      expect(checkout.purchase_amount).to eql('Total: 57.0$')
    end

    it 'should not add promotions for 2 t-shirts' do
      checkout.scan('TSHIRT')
      checkout.scan('TSHIRT')
      expect(checkout.purchase_amount).to eql('Total: 40.0$')
    end
  end

  describe 'apply both promotions if carts contains 2 or more vouchers and more then 2 t-shirts' do
    it 'should add promotions for more than 2 t-shirts' do
      checkout.scan('TSHIRT')
      checkout.scan('TSHIRT')
      checkout.scan('TSHIRT')
      checkout.scan('VOUCHER')
      checkout.scan('VOUCHER')
      expect(checkout.purchase_amount).to eql('Total: 62.0$')
    end
  end
end