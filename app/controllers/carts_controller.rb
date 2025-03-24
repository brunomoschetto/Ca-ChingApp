class CartsController < ApplicationController
  def create
    @cart = Cart.create
    redirect_to cart_path(@cart)
  end

  def add_product
    @cart = Cart.find(params[:id])
    @product = Product.find(params[:product_id])

    @cart.cart_items.create(product: @product, quantity: 1)

    respond_to do |format|
      format.html { redirect_to products_path }
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "cart_section",
          partial: "products/cart",
          locals: { cart: @cart }
        )
      }
    end
  end
end
