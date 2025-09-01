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
    groups = cart_items.includes(:product).group_by { |ci| ci.product.code }
    total  = 0

    groups.each do |code, items|
      qty        = items.sum(&:quantity)
      unit_price = items.first.product.price
      rule       = DiscountRule.find_by(product_code: code)

      total += price_for_group(unit_price, qty, rule)
    end

    total.round(2)
  end

  def remove_item_by_id(cart_item_id)
    item = cart_items.find_by(id: cart_item_id)
    return self unless item

    if item.quantity && item.quantity > 1
      item.decrement!(:quantity)
    else
      item.destroy
    end
    self
  end

  private

  def price_for_group(unit_price, qty, rule)
    return unit_price * qty unless rule

    case rule.rule_type
    when DiscountRule::T_BOGOF
      apply_bogof(unit_price, qty)
    when DiscountRule::T_BULK_PRICE
      apply_bulk_price(unit_price, qty, rule.value)
    when DiscountRule::T_BULK_PERCENT
      apply_bulk_percentage(unit_price, qty, rule.value)
    else
      unit_price * qty
    end
  end

  def apply_bogof(unit_price, qty)
    billable = (qty / 2.0).ceil
    unit_price * billable
  end

  def apply_bulk_price(unit_price, qty, bulk_unit_price)
    if qty >= DiscountRule::MIN_BULK_QTY
      bulk_unit_price * qty
    else
      unit_price * qty
    end
  end

  def apply_bulk_percentage(unit_price, qty, factor)
    if qty >= DiscountRule::MIN_BULK_QTY
      (unit_price * factor) * qty
    else
      unit_price * qty
    end
  end
end
