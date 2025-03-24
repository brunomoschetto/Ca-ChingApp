require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product = Product.new(code: "GR1", name: "Green Tea", price: 3.11)
    expect(product).to be_valid
  end

  it "is not valid without a code" do
    product = Product.new(name: "Green Tea", price: 3.11)
    expect(product).to_not be_valid
  end

  it "is not valid with a duplicate code" do
    Product.create(code: "GR1", name: "Green Tea", price: 3.11)
    product = Product.new(code: "GR1", name: "Another Tea", price: 4.50)
    expect(product).to_not be_valid
  end

  it "is not valid without a name" do
    product = Product.new(code: "GR1", price: 3.11)
    expect(product).to_not be_valid
  end

  it "is not valid without a price" do
    product = Product.new(code: "GR1", name: "Green Tea")
    expect(product).to_not be_valid
  end

  it "is not valid with a negative price" do
    product = Product.new(code: "GR1", name: "Green Tea", price: -1.00)
    expect(product).to_not be_valid
  end

  it "is valid with a price of zero" do
    product = Product.new(code: "GR1", name: "Green Tea", price: 0.00)
    expect(product).to be_valid
  end
end
