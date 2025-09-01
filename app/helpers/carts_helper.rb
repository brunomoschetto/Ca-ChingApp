module CartsHelper
  def bulk_threshold
    DiscountRule::MIN_BULK_QTY
  end

  def pre_discount_subtotal(cart)
    cart.cart_items.sum { |it| it.product.price * it.quantity }
  end

  def promo_applied_for(item)
    rule = DiscountRule.find_by(product_code: item.product.code)
    return nil unless rule

    case rule.rule_type
    when DiscountRule::T_BOGOF
      "Promo applied" if item.quantity >= 2
    when DiscountRule::T_BULK_PRICE, DiscountRule::T_BULK_PERCENT
      "Promo applied" if item.quantity >= DiscountRule::MIN_BULK_QTY
    end
  end
end
