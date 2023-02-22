# Store Checkout Application
This application is used to add the products in the cart. On the basis of your purchase it will apply promotions.
- 2-for-1 promotions (buy two of the same product, get one free), and would like for there to be a 2-for-1 special on VOUCHER items
- There can also be discounts on bulk purchases (buying x or more of a product, the price of that product is reduced), and demands that if you buy 3 or more TSHIRT
items, the price per unit should be 19.00 $.

## Environment:
- Ruby version should be greater than 2.6

Steps to run the application:
- bundle install
- ruby execute.rb

## For this Application test cases are wriitten with help of rspec

For running test cases please run command:
`rspec spec`

Examples based on above pricing rules:
1. Items: VOUCHER, TSHIRT, MUG
Total: 32.50 $
2. Items: VOUCHER, TSHIRT, VOUCHER
Total: 25.00 $
3. Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT
Total: 81.00 $
4. Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT
Total: 74.50 $