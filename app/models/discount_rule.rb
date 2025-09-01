class DiscountRule < ApplicationRecord
  T_BOGOF        = 'bogof'.freeze
  T_BULK_PRICE   = 'bulk_price'.freeze
  T_BULK_PERCENT = 'bulk_percentage'.freeze
  TYPES          = [T_BOGOF, T_BULK_PRICE, T_BULK_PERCENT].freeze

  MIN_BULK_QTY   = 3

  validates :name, :product_code, :rule_type, presence: true
  validates :rule_type, inclusion: { in: TYPES }
  validates :value, presence: true, unless: -> { rule_type == T_BOGOF }
end
