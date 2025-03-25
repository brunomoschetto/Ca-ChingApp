class CreateDiscountRules < ActiveRecord::Migration[7.1]
  def change
    create_table :discount_rules do |t|
      t.string :name
      t.string :product_code
      t.string :rule_type
      t.decimal :value

      t.timestamps
    end
  end
end
