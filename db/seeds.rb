puts "Deleting previous products and discount rules..."
CartItem.destroy_all
Cart.destroy_all
DiscountRule.destroy_all
Product.destroy_all

Product.find_or_create_by(code: "GR1") do |product|
  product.name = "Green Tea"
  product.price = 3.11
end

Product.find_or_create_by(code: "SR1") do |product|
  product.name = "Strawberries"
  product.price = 5.00
end

Product.find_or_create_by(code: "CF1") do |product|
  product.name = "Coffee"
  product.price = 11.23
end

puts "======================================"
puts "Created #{Product.count} products"
puts "======================================"


DiscountRule.find_or_create_by(product_code: "GR1") do |rule|
  rule.name = "Buy one get one free"
  rule.rule_type = "bogof"
end

DiscountRule.find_or_create_by(product_code: "SR1") do |rule|
  rule.name = "Bulk discount strawberries"
  rule.rule_type = "bulk_price"
  rule.value = 4.50
end

DiscountRule.find_or_create_by(product_code: "CF1") do |rule|
  rule.name = "Coffee volume discount"
  rule.rule_type = "bulk_percentage"
  rule.value = 0.6667
end

puts "======================================"
puts "Seeds created successfully!"
puts "Created #{DiscountRule.count} discount rules"
puts "======================================"
