class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def add_product
    @cart = current_cart
    product = Product.find(params[:product_id])

    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity = (item.quantity || 0) + 1
    item.save!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: 'Added to cart' }
    end
  end

  def remove_item
    @cart = current_cart
    @cart.remove_item_by_id(params[:cart_item_id])

    respond_to do |format|
      format.turbo_stream { render :add_product }
      format.html { redirect_to products_path, notice: 'Item removed' }
    end
  end
end
