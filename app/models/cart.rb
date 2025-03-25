class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id)
    product = Product.find(product_id)
    cart_item = cart_items.find_by(product_id: product_id)

    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      cart_items.create(product_id: product_id, quantity: 1)
    end
  end

  def total_price
    total = 0

    product_groups = cart_items.includes(:product).group_by { |item| item.product.code }

    product_groups.each do |product_code, items|
      product = items.first.product
      quantity = items.sum(&:quantity)

      rule = DiscountRule.find_by(product_code: product_code)

      if rule.nil?
        total += product.price * quantity
      else
        case rule.rule_type
        when "bogof"
          paid_quantity = (quantity / 2.0).ceil
          total += product.price * paid_quantity
        when "bulk_price"
          if quantity >= 3
            total += rule.value * quantity
          else
            total += product.price * quantity
          end
        when "bulk_percentage"
          if quantity >= 3
            discounted_price = product.price * rule.value
            total += discounted_price * quantity
          else
            total += product.price * quantity
          end
        end
      end
    end

    total.round(2)
  end
end
