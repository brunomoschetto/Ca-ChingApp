require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:product) { Product.create(code: "GR1", name: "Green Tea", price: 3.11) }

  before do
    session[:cart_id] = Cart.create.id
  end

  describe "GET #show" do
    it "renders the cart show template" do
      get :show
      expect(response).to render_template(:show)
    end

    it "assigns the current cart to @cart" do
      get :show
      expect(assigns(:cart)).to be_a(Cart)
      expect(assigns(:cart).id).to eq(session[:cart_id])
    end
  end

  describe "POST #add_product" do
    context "when adding a new product" do
      it "creates a new cart item" do
        expect {
          post :add_product, params: { product_id: product.id }
        }.to change(CartItem, :count).by(1)
      end

      it "sets the cart item quantity to 1" do
        post :add_product, params: { product_id: product.id }
        expect(CartItem.last.quantity).to eq(1)
      end

      it "redirects to the cart path with a success notice" do
        post :add_product, params: { product_id: product.id }
        expect(response).to redirect_to(cart_path)
        expect(flash[:notice]).to eq("#{product.name} added to cart!")
      end
    end

    context "when adding an existing product" do
      let!(:existing_cart_item) { CartItem.create(cart_id: session[:cart_id], product: product, quantity: 1) }

      it "increases the existing cart item quantity" do
        expect {
          post :add_product, params: { product_id: product.id }
        }.to change { existing_cart_item.reload.quantity }.from(1).to(2)
      end

      it "does not create a new cart item" do
        expect {
          post :add_product, params: { product_id: product.id }
        }.to_not change(CartItem, :count)
      end
    end
  end

  describe "DELETE #remove_item" do
    let!(:cart_item) { CartItem.create(cart_id: session[:cart_id], product: product, quantity: 2) }

    context "when item quantity is greater than 1" do
      it "decreases the cart item quantity" do
        expect {
          delete :remove_item, params: { cart_item_id: cart_item.id }
        }.to change { cart_item.reload.quantity }.from(2).to(1)
      end
    end

    context "when item quantity is 1" do
      let!(:single_item_cart) { CartItem.create(cart_id: session[:cart_id], product: product, quantity: 1) }

      it "removes the cart item completely" do
        expect {
          delete :remove_item, params: { cart_item_id: single_item_cart.id }
        }.to change(CartItem, :count).by(-1)
      end
    end

    it "redirects to the cart path with a success notice" do
      delete :remove_item, params: { cart_item_id: cart_item.id }
      expect(response).to redirect_to(cart_path)
      expect(flash[:notice]).to eq("Item removed from cart")
    end
  end

  describe "#current_cart" do
    it "creates a new cart if no cart exists in the session" do
      session[:cart_id] = nil
      cart = controller.send(:current_cart)
      expect(cart).to be_a(Cart)
      expect(session[:cart_id]).to eq(cart.id)
    end

    it "returns existing cart from session" do
      existing_cart = Cart.find(session[:cart_id])
      cart = controller.send(:current_cart)
      expect(cart).to eq(existing_cart)
    end
  end
end
