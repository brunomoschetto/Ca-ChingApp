class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart = current_cart
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
