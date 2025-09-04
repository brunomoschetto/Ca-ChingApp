class ProductsController < ApplicationController
  before_action :set_cart, only: :index

  def index
    @products = Product.all
    @cart = current_cart

    respond_to do |format|
      format.html
      format.json do
        render json: @products.map { |p|
          rule = DiscountRule.find_by(product_code: p.code)
          {
            id: p.id,
            code: p.code,
            name: p.name,
            price: p.price,
            promo: rule&.rule_type,
            promo_value: rule&.value
          }
        }
      end
    end
  end

  private

  def set_cart
    @cart = current_cart
  end
end
