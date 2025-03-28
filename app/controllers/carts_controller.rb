class CartsController < ApplicationController

  def show
    @cart = current_cart
  end

  def add_product
    product = Product.find(params[:product_id])
    @cart = current_cart

    @cart.add_product(product.id)

    redirect_to cart_path, notice: "#{product.name} added to cart!"
  end

  def remove_item
    @cart = current_cart
    cart_item = @cart.cart_items.find(params[:cart_item_id])

    if cart_item.quantity > 1
      cart_item.quantity -= 1
      cart_item.save
    else
      cart_item.destroy
    end

    redirect_to cart_path, notice: "Item removed from cart"
  end
end
