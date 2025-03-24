class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart = Cart.create
  end
end
