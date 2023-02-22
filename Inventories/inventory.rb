# frozen_string_literal: true

require_relative '../products/product.rb'
require 'byebug'
require 'terminal-table'
require 'json'

# inventory.rb
class Inventory
  def initialize(*args)
    @inventory = args.map { |product| [product.code.to_sym, product] }.to_h
  end

  def find(code)
    @inventory[code.to_sym]
  end

  def products_quantity
    @inventory.size
  end

  def list
    products = JSON.parse(File.read('products.json'))
    products = products.map{|product| product.values}
    Terminal::Table.new(title: "Store", headings: [ 'Code', 'Name', 'Price'], rows: products)
  end

  def products
    @inventory.values
  end

  def valid_codes
    @inventory.values.map(&:code)
  end
end
