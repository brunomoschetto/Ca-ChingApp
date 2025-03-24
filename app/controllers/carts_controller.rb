class CartsController < ApplicationController
  def create
    @cart = Cart.create
    redirect_to cart_path(@cart)
  end

  def add_product
    @cart = Cart.find(params[:id])
    @product = Product.find(params[:product_id])

    @cart.cart_items.create(product: @product, quantity: 1)

    redirect_to cart_path(@cart), notice: "Product added to cart!"
  end
end
