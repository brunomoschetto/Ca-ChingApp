require 'rails_helper'

RSpec.describe "products/index", type: :view do
  it "shows promo badges" do
    p = Product.create!(code: Product::CODE_GR1, name: "Green Tea", price: 3.11)
    DiscountRule.create!(name: "BOGOF", product_code: p.code, rule_type: DiscountRule::T_BOGOF)
    assign(:products, [p])
    assign(:cart, Cart.create!)

    render
    expect(rendered).to include("Buy 1 Get 1")
  end
end
