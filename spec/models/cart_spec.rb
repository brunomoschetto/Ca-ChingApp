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
      product = Product.create!(code: Product::CODE_GR1, name: "Green Tea", price: 3.11)
      cart.cart_items.create!(product: product, quantity: 2)

      expect { cart.destroy }.to change { CartItem.count }.by(-1)
    end
  end

  describe "discount rules" do
    let!(:green_tea) { Product.create(code: Product::CODE_GR1, name: "Green Tea", price: 3.11) }
    let!(:strawberry) { Product.create(code: Product::CODE_SR1, name: "Strawberries", price: 5.00) }
    let!(:coffee) { Product.create(code: Product::CODE_CF1, name: "Coffee", price: 11.23) }

    before do
      DiscountRule.create!(
        name: "Buy one get one free",
        product_code: Product::CODE_GR1,
        rule_type: DiscountRule::T_BOGOF
      )

      DiscountRule.create!(
        name: "Bulk discount strawberries",
        product_code: Product::CODE_SR1,
        rule_type: DiscountRule::T_BULK_PRICE,
        value: 4.50
      )

      DiscountRule.create!(
        name: "Coffee volume discount",
        product_code: Product::CODE_CF1,
        rule_type: DiscountRule::T_BULK_PERCENT,
        value: 0.6667
      )
    end

    describe "#total_price" do
      context "with buy-one-get-one-free discount (Green Tea)" do
        it "charges for 1 when buying 2" do
          cart = Cart.create!
          2.times do
            cart.add_product(green_tea.id)
          end

          expect(cart.total_price).to eq(3.11)
        end

        it "charges for 2 when buying 3" do
          cart = Cart.create!
          3.times do
            cart.add_product(green_tea.id)
          end

          expect(cart.total_price).to eq(6.22)
        end
      end

      context "with bulk price discount (Strawberries)" do
        it "uses normal price when buying less than 3" do
          cart = Cart.create!
          2.times do
            cart.add_product(strawberry.id)
          end

          expect(cart.total_price).to eq(10.00)
        end

        it "uses discounted price when buying 3 or more" do
          cart = Cart.create!
          3.times do
            cart.add_product(strawberry.id)
          end

          expect(cart.total_price).to eq(13.50)
        end
      end

      context "with bulk percentage discount (Coffee)" do
        it "uses normal price when buying less than 3" do
          cart = Cart.create!
          2.times do
            cart.add_product(coffee.id)
          end

          expect(cart.total_price).to eq(22.46)
        end

        it "uses discounted price when buying 3 or more" do
          cart = Cart.create!
          3.times do
            cart.add_product(coffee.id)
          end

          # 3 * (11.23 * 2/3) ≈ 22.46
          expect(cart.total_price).to be_within(0.01).of(22.46)
        end
      end

      context "with the provided test cases" do
        it "calculates GR1,GR1 = 3.11€" do
          cart = Cart.create!
          cart.add_product(green_tea.id)
          cart.add_product(green_tea.id)

          expect(cart.total_price).to eq(3.11)
        end

        it "calculates SR1,SR1,GR1,SR1 = 16.61€" do
          cart = Cart.create!
          cart.add_product(strawberry.id)
          cart.add_product(strawberry.id)
          cart.add_product(green_tea.id)
          cart.add_product(strawberry.id)

          expect(cart.total_price).to eq(16.61)
        end

        it "calculates GR1,CF1,SR1,CF1,CF1 = 30.57€" do
          cart = Cart.create!
          cart.add_product(green_tea.id)
          cart.add_product(coffee.id)
          cart.add_product(strawberry.id)
          cart.add_product(coffee.id)
          cart.add_product(coffee.id)

          expect(cart.total_price).to be_within(0.01).of(30.57)
        end
      end
    end
  end

  describe "#add_product" do
    let(:product) { Product.create(code: Product::CODE_GR1, name: "Green Tea", price: 3.11) }

    it "increases the quantity of an existing cart item" do
      cart = Cart.create!
      cart.add_product(product.id)
      cart.add_product(product.id)

      cart_item = cart.cart_items.find_by(product_id: product.id)
      expect(cart_item.quantity).to eq(2)
    end

    it "creates a new cart item when the product is not in the cart" do
      cart = Cart.create!
      expect {
        cart.add_product(product.id)
      }.to change(cart.cart_items, :count).by(1)
    end
  end

    describe "#remove_item_by_id" do
    it "decrements quantity when > 1" do
      cart = Cart.create!
      product = Product.create!(code: "T1", name: "Test 1", price: 1.0)
      item = CartItem.create!(cart: cart, product: product, quantity: 2)

      cart.remove_item_by_id(item.id)

      expect(item.reload.quantity).to eq(1)
    end

    it "destroys the item when quantity is 1" do
      cart = Cart.create!
      product = Product.create!(code: "T2", name: "Test 2", price: 1.0)
      item = CartItem.create!(cart: cart, product: product, quantity: 1)

      cart.remove_item_by_id(item.id)

      expect(CartItem.find_by(id: item.id)).to be_nil
    end

    it "does nothing (no error) if the item is not found" do
      cart = Cart.create!
      expect { cart.remove_item_by_id(999_999) }.not_to raise_error
      expect(cart.cart_items.count).to eq(0)
    end
  end
end
