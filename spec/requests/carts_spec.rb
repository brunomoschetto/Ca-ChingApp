require 'rails_helper'

RSpec.describe "Carts", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get cart_path
      expect(response).to have_http_status(:success)
    end
  end
end
