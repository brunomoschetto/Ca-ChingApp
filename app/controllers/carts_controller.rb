class CartsController < ApplicationController

  def show
    @cart = current_cart
  end

  def add_product
    product = Product.find(params[:product_id])
    @cart = current_cart
    cart_item = @cart.cart_items.find_by(product_id: product.id)

    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      @cart.cart_items.create(product: product, quantity: 1)
    end
    
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

  private

  def current_cart
    Cart.find_or_create_by(id: session[:cart_id]).tap do |cart|
      session[:cart_id] = cart.id
    end
  end
end
