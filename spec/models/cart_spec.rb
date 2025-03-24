require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "associations" do
    it "has many cart_items" do
      association = described_class.reflect_on_association(:cart_items)
      expect(association.macro).to eq(:has_many)
    end

    it "has many products through cart_items" do
      association = described_class.reflect_on_association(:products)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:cart_items)
    end

    it "destroys associated cart_items when destroyed" do
      cart = Cart.create!
      product = Product.create!(code: "GR1", name: "Green Tea", price: 3.11)
      cart.cart_items.create!(product: product, quantity: 2)

      expect { cart.destroy }.to change { CartItem.count }.by(-1)
    end
  end
end
