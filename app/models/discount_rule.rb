class DiscountRule < ApplicationRecord
  T_BOGOF        = 'bogof'.freeze
  T_BULK_PRICE   = 'bulk_price'.freeze
  T_BULK_PERCENT = 'bulk_percentage'.freeze
  TYPES          = [T_BOGOF, T_BULK_PRICE, T_BULK_PERCENT].freeze

  MIN_BULK_QTY   = 3

  validates :name, :product_code, :rule_type, presence: true
  validates :rule_type, inclusion: { in: TYPES }
  validates :value,
            presence: { message: "can't be blank for bulk price discounts" },
            if: -> { rule_type == T_BULK_PRICE }
  validates :value,
            presence: { message: "can't be blank for bulk percentage discounts" },
            if: -> { rule_type == T_BULK_PERCENT }
  validates :value, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
