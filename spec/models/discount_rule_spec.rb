# spec/models/discount_rule_spec.rb
require 'rails_helper'

RSpec.describe DiscountRule, type: :model do
  it "is valid with a name, product_code and rule_type" do
    rule = DiscountRule.new(
      name: "Buy one get one free",
      product_code: "GR1",
      rule_type: "bogof"
    )
    expect(rule).to be_valid
  end

  it "is invalid without a name" do
    rule = DiscountRule.new(name: nil)
    rule.valid?
    expect(rule.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a product_code" do
    rule = DiscountRule.new(product_code: nil)
    rule.valid?
    expect(rule.errors[:product_code]).to include("can't be blank")
  end

  it "is invalid without a rule_type" do
    rule = DiscountRule.new(rule_type: nil)
    rule.valid?
    expect(rule.errors[:rule_type]).to include("can't be blank")
  end

  context "with different rule types" do
    it "allows bogof rule type without a value" do
      rule = DiscountRule.new(
        name: "Buy one get one free",
        product_code: "GR1",
        rule_type: "bogof",
        value: nil
      )
      expect(rule).to be_valid
    end

    it "requires a value for bulk_price rule type" do
      rule = DiscountRule.new(
        name: "Bulk discount",
        product_code: "SR1",
        rule_type: "bulk_price",
        value: nil
      )
      rule.valid?
      expect(rule.errors[:value]).to include("can't be blank for bulk price discounts")
    end

    it "requires a value for bulk_percentage rule type" do
      rule = DiscountRule.new(
        name: "Percentage discount",
        product_code: "CF1",
        rule_type: "bulk_percentage",
        value: nil
      )
      rule.valid?
      expect(rule.errors[:value]).to include("can't be blank for bulk percentage discounts")
    end
  end
end
