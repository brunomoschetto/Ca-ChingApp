class ProductsController < ApplicationController
  before_action :set_cart, only: :index

  def index
    @products = Product.all
  end

  private

  def set_cart
    @cart = current_cart
  end
end
