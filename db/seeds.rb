puts "Deleting previous products and discount rules..."
CartItem.delete_all
Cart.delete_all
DiscountRule.delete_all
Product.delete_all

gr1 = Product.create!(
  code: Product::CODE_GR1,
  name: "Green Tea",
  price: 3.11
)

sr1 = Product.create!(
  code: Product::CODE_SR1,
  name: "Strawberries",
  price: 5.00
)

cf1 = Product.create!(
  code: Product::CODE_CF1,
  name: "Coffee",
  price: 11.23
)

# Reglas de descuento
DiscountRule.create!(
  name: "Buy one get one free",
  product_code: Product::CODE_GR1,
  rule_type: DiscountRule::T_BOGOF
)

DiscountRule.create!(
  name: "Bulk discount strawberries",
  product_code: Product::CODE_SR1,
  rule_type: DiscountRule::T_BULK_PRICE,
  value: 4.50
)

DiscountRule.create!(
  name: "Coffee volume discount",
  product_code: Product::CODE_CF1,
  rule_type: DiscountRule::T_BULK_PERCENT,
  value: 0.6667
)

puts "======================================"
puts "Seeded: #{Product.count} products, #{DiscountRule.count} rules"
puts "======================================"
