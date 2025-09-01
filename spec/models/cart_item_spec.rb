require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe "associations" do
    it "belongs to a product" do
      association = described_class.reflect_on_association(:product)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a cart" do
      association = described_class.reflect_on_association(:cart)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      product = Product.create(code: Product::CODE_GR1, name: "Green Tea", price: 3.11)
      cart = Cart.create
      cart_item = CartItem.new(product: product, cart: cart, quantity: 2)
      expect(cart_item).to be_valid
    end

    it "is not valid without a product" do
      cart = Cart.create
      cart_item = CartItem.new(cart: cart, quantity: 2)
      expect(cart_item).to_not be_valid
    end

    it "is not valid without a cart" do
      product = Product.create(code: Product::CODE_GR1, name: "Green Tea", price: 3.11)
      cart_item = CartItem.new(product: product, quantity: 2)
      expect(cart_item).to_not be_valid
    end

    it "is valid without a quantity" do
      product = Product.create(code: Product::CODE_GR1, name: "Green Tea", price: 3.11)
      cart = Cart.create
      cart_item = CartItem.new(product: product, cart: cart)
      expect(cart_item).to be_valid
    end
  end
end
