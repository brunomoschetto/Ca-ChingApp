module ProductsHelper
  def promo_badge_for(product)
    rule = DiscountRule.find_by(product_code: product.code)
    return unless rule

    case rule.rule_type
    when DiscountRule::T_BOGOF
      content_tag(:span, "Buy 1 Get 1", class: "badge bg-success")
    when DiscountRule::T_BULK_PRICE
      content_tag(:span, "Bulk price from #{DiscountRule::MIN_BULK_QTY}", class: "badge bg-info")
    when DiscountRule::T_BULK_PERCENT
      content_tag(:span, "Bulk discount from #{DiscountRule::MIN_BULK_QTY}", class: "badge bg-info")
    end
  end
end
