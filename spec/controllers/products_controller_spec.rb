require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    it "assigns @products" do
      product = Product.create(code: Product::CODE_GR1, name: "Green Tea", price: 3.11)
      get :index
      expect(assigns(:products)).to eq([product])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
