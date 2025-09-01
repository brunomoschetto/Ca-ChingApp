class Product < ApplicationRecord
  CODE_GR1 = 'GR1'.freeze
  CODE_SR1 = 'SR1'.freeze
  CODE_CF1 = 'CF1'.freeze

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :cart_items
  has_many :carts, through: :cart_items
end
