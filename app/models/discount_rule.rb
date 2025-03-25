class DiscountRule < ApplicationRecord
  validates :name, presence: true
  validates :product_code, presence: true
  validates :rule_type, presence: true

  validate :value_required_for_certain_rule_types

  private

  def value_required_for_certain_rule_types
    if rule_type == "bulk_price" && value.blank?
      errors.add(:value, "can't be blank for bulk price discounts")
    end

    if rule_type == "bulk_percentage" && value.blank?
      errors.add(:value, "can't be blank for bulk percentage discounts")
    end
  end
end
