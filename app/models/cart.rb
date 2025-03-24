class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def empty?
    cart_items.empty?
  end

  def total_price
    cart_items.sum { |item| item.product.price * item.quantity }
  end
end
